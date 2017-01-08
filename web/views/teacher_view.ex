defmodule Naranjo.TeacherView do
  use Naranjo.Web, :view

  def weekdays do
    Naranjo.Weekday.days_list
  end

  def available_hours do
    Naranjo.Weekday.available_hours
  end

  def checked(true), do: "checked"
  def checked(false), do: ""
end
