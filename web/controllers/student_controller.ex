defmodule Naranjo.StudentController do
  use Naranjo.Web, :controller

  alias Naranjo.Student

  def index(conn, _params) do
    # students = Repo.all(from s in Student, where: s.active == true) |>
    students = Repo.all(Student) |> Repo.preload([:weekday])
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    changeset = Student.changeset(%Student{weekday: %Naranjo.Weekday{}})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    changeset = Student.changeset(%Student{}, student_params)

    case Repo.insert(changeset) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: student_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Repo.get!(Student, id) |> Repo.preload([:weekday])
    changeset = Student.changeset(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Repo.get!(Student, id) |> Repo.preload([:weekday])
    changeset = Student.changeset(student, student_params)

    case (Repo.update(changeset)) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: student_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: student_path(conn, :index))
  end
end
