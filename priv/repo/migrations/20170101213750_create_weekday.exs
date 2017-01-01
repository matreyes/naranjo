defmodule Naranjo.Repo.Migrations.CreateWeekday do
  use Ecto.Migration

  def change do
    create table(:weekdays) do
      add :day, :integer
      add :hours, {:array, :boolean}
      add :student_id, references(:students, on_delete: :nothing)

      timestamps()
    end
    create index(:weekdays, [:student_id])
  end
end
