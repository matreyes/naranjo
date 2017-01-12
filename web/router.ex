defmodule Naranjo.Router do
  use Naranjo.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, username: "naranjo", password: "secret_1x2xx"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Naranjo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/process", ProcessController, :new
    post "/process", ProcessController, :create
    get "/process/:day", ProcessController, :configure
    resources "/students", StudentController
    resources "/teachers", TeacherController
    resources "/rooms", RoomController
  end

  # scope "/api", Naranjo do
  #   pipe_through :api
  # end

end
