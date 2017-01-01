defmodule Naranjo.Weekday do
  use Naranjo.Web, :model

  schema "weekdays" do
    field :day, :integer
    field :hours, :string
    belongs_to :student, Naranjo.Student
    # belongs_to :teacher, Naranjo.Teacher
    # belongs_to :room, Naranjo.Room

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:day, :hours])
    |> validate_required([:day, :hours])
  end
end
