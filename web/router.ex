defmodule Lisztomania.Router do
  use Lisztomania.Web, :router

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

  # Web routes
  scope "/", Lisztomania do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/authorize", AuthorizationController, :authorize
    get "/authenticate", AuthenticationController, :authenticate
  end

  # API routes 
  scope "/api", Lisztomania do
    pipe_through :api

    resources "/users", UserController do 
      resources "/playlists", PlaylistController
    end
  end
end
