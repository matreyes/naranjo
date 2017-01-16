defmodule Naranjo.ProcessController do
  use Naranjo.Web, :controller
  alias Naranjo.Repo
  alias Naranjo.Student
  alias Naranjo.Weekday
  alias Naranjo.Teacher
  alias Naranjo.Room
  alias Naranjo.History

  @repeated_teachers 3

  def configure(conn, %{"day" => day}) do
    history_query = from h in History,
      join: t in Teacher, on: t.id == h.teacher_id,
      order_by: [desc: h.schedule],
      select: %{teacher_id: h.teacher_id, teacher_name: t.name}

    students_query = from s in Student,
      join: w in Weekday, on: s.id == w.student_id,
      where: s.active == true and w.day == ^day

    students_with_history = from [s, w] in students_query,
      preload: [histories: ^history_query, weekday: w]

    teachers_query = from t in Teacher,
      left_join: w in Weekday, on: t.id == w.teacher_id,
      where: t.active == true and w.day == ^day,
      select: %{id: t.id, name: t.name, hours: w.hours}

    rooms_query = from r in Room,
      left_join: w in Weekday, on: r.id == w.room_id,
      where: r.active == true and w.day == ^day,
      select: %{id: r.id, name: r.name, hours: w.hours}

      IO.inspect students_with_history

    students = Repo.all(students_with_history) |> Enum.map(fn(x) -> %{id: x.id, name: x.name, hours: x.weekday.hours, history: Enum.take(x.histories, @repeated_teachers)} end) |> Enum.shuffle
    teachers = Repo.all(teachers_query) |> Enum.shuffle
    rooms = Repo.all(rooms_query)

    render conn, "configure.html", students: students, teachers: teachers, rooms: rooms
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    results = Assignment.process(params) |> Enum.sort(fn(a,b) -> a.hour <= b.hour end)
    render conn, "create.html", results: results
  end

  def history(conn, %{"history" => history, "day" => day}) do
    h = history
      |> Map.values
      |> Enum.map(fn(x) ->
        %{
            schedule: parse_date(x["hour"], day),
            student_id: String.to_integer(x["student"]),
            teacher_id: String.to_integer(x["teacher"]),
            inserted_at: Timex.now,
            updated_at: Timex.now
          }
        end)

    {n, inserted} = Repo.insert_all(History, h, returning: true)

    inserted
      |> Repo.preload([:student, :teacher])
      |> Enum.filter(fn(x) -> Mix.env == :prod or x.student.email == "matreyes@gmail.com" end)
      |> Enum.each(&History.email_student/1)

    conn
    |> put_flash(:info, "Se han enviado los correos.")
    |> redirect(to: page_path(conn, :index))

  end

  defp parse_date(hour, date) do
    hour = hour |> String.rjust(2, ?0)
    {:ok, time} = Timex.parse("#{date} #{hour}", "%d-%m-%Y %H", :strftime)
    time
  end



end
