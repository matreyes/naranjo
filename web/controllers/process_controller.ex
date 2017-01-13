defmodule Naranjo.ProcessController do
  use Naranjo.Web, :controller
  alias Naranjo.Repo
  alias Naranjo.Student
  alias Naranjo.Weekday
  alias Naranjo.Teacher
  alias Naranjo.Room

  def configure(conn, %{"day" => day}) do
    students_query = from s in Student,
      join: w in Weekday, on: s.id == w.student_id,
      where: s.active == true and w.day == ^day,
      select: %{id: s.id, name: s.name, hours: w.hours}

    teachers_query = from t in Teacher,
      left_join: w in Weekday, on: t.id == w.teacher_id,
      where: t.active == true and w.day == ^day,
      select: %{id: t.id, name: t.name, hours: w.hours}

    rooms_query = from r in Room,
      left_join: w in Weekday, on: r.id == w.room_id,
      where: r.active == true and w.day == ^day,
      select: %{id: r.id, name: r.name, hours: w.hours}

    students = Repo.all(students_query) |> Enum.shuffle
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


end
