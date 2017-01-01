defmodule Naranjo.StudentTest do
  use Naranjo.ModelCase

  alias Naranjo.Student

  @valid_attrs %{active: true, email: "some content", name: "some content", notes: "some content", weekday: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Student.changeset(%Student{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Student.changeset(%Student{}, @invalid_attrs)
    refute changeset.valid?
  end
end
