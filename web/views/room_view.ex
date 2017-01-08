defmodule Naranjo.RoomView do
  use Naranjo.Web, :view

  def available_hours do
    Naranjo.Weekday.available_hours
  end

  def checked(true), do: "checked"
  def checked(false), do: ""
end
