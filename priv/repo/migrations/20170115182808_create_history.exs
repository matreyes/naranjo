defmodule Naranjo.Repo.Migrations.CreateHistory do
  use Ecto.Migration

  def change do
    create table(:histories) do
      add :schedule, :naive_datetime
      add :student_id, references(:students, on_delete: :nothing)
      add :teacher_id, references(:teachers, on_delete: :nothing)

      timestamps()
    end
    create index(:histories, [:student_id])
    create index(:histories, [:teacher_id])

  end
end
