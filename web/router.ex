defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
  end

  scope "/api", HelloPhoenix do
    pipe_through :api

    resources "/contacts", ContactController

    scope "/v1", V1, as: :v1 do
      resources "/images", ImageController
    end
  end

  socket "/ws", HelloPhoenix do
    channel "rooms:*", RoomChannel
  end
end
