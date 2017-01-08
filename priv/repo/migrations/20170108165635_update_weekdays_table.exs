defmodule Naranjo.Repo.Migrations.UpdateWeekdaysTable do
  use Ecto.Migration

  def change do
    alter table(:weekdays) do
      add :teacher_id, references(:teachers)
      add :room_id, references(:rooms)
    end
  end

end
