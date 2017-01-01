defmodule Naranjo.WeekdayTest do
  use Naranjo.ModelCase

  alias Naranjo.Weekday

  @valid_attrs %{day: 42, hours: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Weekday.changeset(%Weekday{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Weekday.changeset(%Weekday{}, @invalid_attrs)
    refute changeset.valid?
  end
end
