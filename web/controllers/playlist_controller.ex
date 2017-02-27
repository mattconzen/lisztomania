require IEx 
defmodule Lisztomania.PlaylistController do
  use Lisztomania.Web, :controller
  plug Lisztomania.Plugs.Auth

  def index(conn, %{"user_id" => user}) do
    case Spotify.Playlist.get_users_playlists(conn, user) do 
      { :ok, response } -> 
        render(conn, "show.json", playlists: response.items)
      { :error, message } ->
        render(conn, "errors.json", message: message)
    end
  end

  def create(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

  def show(conn, _params) do
    render conn, "errors.json", message: "oops"    
  end

  def update(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

  def delete(conn, _params) do
    render conn, "errors.json", message: "oops"
  end
end
