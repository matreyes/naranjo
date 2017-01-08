defmodule Naranjo.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :active, :boolean, default: false, null: false

      timestamps()
    end
  end
end
