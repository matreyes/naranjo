defmodule Naranjo.PageController do
  use Naranjo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
