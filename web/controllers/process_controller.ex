defmodule Naranjo.ProcessController do
  use Naranjo.Web, :controller

  def configure(conn, %{"day" => day}) do
    IO.inspect day
    render conn, "configure.html"
  end

  def new(conn, _params) do
    render conn, "new.html"
  end


end
