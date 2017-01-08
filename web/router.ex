defmodule Naranjo.Router do
  use Naranjo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Naranjo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/students", StudentController
    resources "/teachers", TeacherController
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Naranjo do
  #   pipe_through :api
  # end
end
