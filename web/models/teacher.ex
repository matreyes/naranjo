defmodule Naranjo.Teacher do
  use Naranjo.Web, :model
  alias Naranjo.Weekday
  
  schema "teachers" do
    field :name, :string
    field :email, :string
    field :active, :boolean, default: false
    field :notes, :string
    has_many :weekdays, Weekday, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :active, :notes])
    |> cast_assoc(:weekdays, with: &Weekday.changeset/2)
    |> validate_required([:name, :email, :active, :notes])
  end
end
