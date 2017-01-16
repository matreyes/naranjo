defmodule Naranjo.HistoryController do
  use Naranjo.Web, :controller

  alias Naranjo.History
  alias Naranjo.Teacher
  alias Naranjo.Student


  def index(conn, %{"student" => student}) do
    history = Repo.all(
      from h in history_list,
      where: h.student_id == ^student
    )
    render(conn, "index.html", histories: history)
  end
  def index(conn, %{"teacher" => teacher}) do
    history = Repo.all(
      from h in history_list,
      where: h.teacher_id == ^teacher
    )
    render(conn, "index.html", histories: history)
  end
  def index(conn, _params) do
    history = Repo.all(history_list)
    render(conn, "index.html", histories: history)
  end


  def history_list do
    from h in History,
      join: t in Teacher, on: t.id == h.teacher_id,
      join: s in Student, on: s.id == h.student_id,
      select: %{schedule: h.schedule, teacher: t.name, student: s.name},
      order_by: [desc: h.inserted_at],
      limit: 100
  end

end
