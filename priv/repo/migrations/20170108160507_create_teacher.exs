defmodule Naranjo.Repo.Migrations.CreateTeacher do
  use Ecto.Migration

  def change do
    create table(:teachers) do
      add :name, :string
      add :email, :string
      add :active, :boolean, default: false, null: false
      add :notes, :text

      timestamps()
    end

  end
end
