defmodule Naranjo.ProcessView do
  use Naranjo.Web, :view

  def weekdays do
    Naranjo.Weekday.days_list
  end
end
