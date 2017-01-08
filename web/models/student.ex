defmodule Naranjo.Student do
  use Naranjo.Web, :model
  alias Naranjo.Weekday

  schema "students" do
    field :name, :string
    field :email, :string
    field :active, :boolean, default: true
    field :notes, :string
    has_one :weekday, Weekday, on_delete: :delete_all


    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :active, :notes])
    |> cast_assoc(:weekday, required: true, with: &Weekday.changeset/2)
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
