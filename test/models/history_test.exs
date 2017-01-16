defmodule Naranjo.HistoryTest do
  use Naranjo.ModelCase

  alias Naranjo.History

  @valid_attrs %{schedule: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = History.changeset(%History{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = History.changeset(%History{}, @invalid_attrs)
    refute changeset.valid?
  end
end
