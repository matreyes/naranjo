defmodule Naranjo.Repo.Migrations.CreateStudent do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :name, :string
      add :email, :string
      add :active, :boolean, default: false, null: false
      add :notes, :text

      timestamps()
    end

  end
end
