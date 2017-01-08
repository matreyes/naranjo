defmodule Naranjo.Room do
  use Naranjo.Web, :model
  alias Naranjo.Weekday

  schema "rooms" do
    field :name, :string
    field :active, :boolean, default: false
    has_many :weekdays, Weekday, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :active])
    |> cast_assoc(:weekdays, with: &Weekday.changeset/2)
    |> validate_required([:name, :active])
  end
end
