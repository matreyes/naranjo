defmodule Naranjo.History do
  use Naranjo.Web, :model

  schema "histories" do
    field :schedule, Timex.Ecto.DateTime
    belongs_to :student, Naranjo.Student
    belongs_to :teacher, Naranjo.Teacher

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:schedule])
    |> validate_required([:schedule])
  end

  def email_student(struct) do
    Naranjo.Email.student_schedule(struct) |> Naranjo.Mailer.deliver_later
  end
end
