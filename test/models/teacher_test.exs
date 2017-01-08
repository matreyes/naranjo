defmodule Naranjo.TeacherTest do
  use Naranjo.ModelCase

  alias Naranjo.Teacher

  @valid_attrs %{active: true, email: "some content", name: "some content", notes: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Teacher.changeset(%Teacher{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Teacher.changeset(%Teacher{}, @invalid_attrs)
    refute changeset.valid?
  end
end
