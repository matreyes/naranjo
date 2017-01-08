defmodule Naranjo.StudentView do
  use Naranjo.Web, :view

  def weekdays do
    Keyword.keys(WeekdayEnum.__enum_map__())
  end

  def available_hours do
    Naranjo.Weekday.available_hours
  end

  def checked(true), do: "checked"
  def checked(false), do: ""

end
