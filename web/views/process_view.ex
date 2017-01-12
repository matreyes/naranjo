defmodule Naranjo.ProcessView do
  use Naranjo.Web, :view

  def weekdays do
    Naranjo.Weekday.days_list
  end

  def render("default.json", %{students: students, teachers: teachers, rooms: rooms}) do
    %{students: students, teachers: teachers, rooms: rooms}
  end
end
