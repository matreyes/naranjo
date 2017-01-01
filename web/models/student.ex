defmodule Naranjo.Student do
  use Naranjo.Web, :model

  schema "students" do
    field :name, :string
    field :email, :string
    field :active, :boolean, default: true
    field :notes, :string
    has_one :weekday, Naranjo.Weekday


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :active, :notes])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
