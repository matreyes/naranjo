defmodule Naranjo.HistoryView do
  use Naranjo.Web, :view

  def prettydate(datetime) do
    Timex.format!(datetime, "%d/%m/%Y %H:%M",:strftime)
  end
end
