defmodule Naranjo.Weekday do
  use Naranjo.Web, :model

  @available_hours [7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]
  @default_hours [false, false, true, true, true, true, true, true, true, true, true, true, false, false, false, false]

  schema "weekdays" do
    field :day, WeekdayEnum
    field :hours, {:array, :boolean}, default: @default_hours
    belongs_to :student, Naranjo.Student
    # belongs_to :teacher, Naranjo.Teacher
    # belongs_to :room, Naranjo.Room

    timestamps()
  end

  def available_hours, do: @available_hours
  def default_hours, do: @default_hours

  def reference_hours(string_array) do
    arr = Enum.map(string_array, &String.to_integer/1)
    Enum.with_index(@available_hours)
      |> Enum.map(fn({_v,k}) -> Enum.member?(arr, k) end)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    new_hours_params = case params do
      %{"hours" => hours} -> Map.merge(params, %{"hours" => reference_hours(hours)})
      _ -> params
    end
    struct
    |> cast(new_hours_params, [:day, :hours])
    |> validate_required([:day])
  end
end
