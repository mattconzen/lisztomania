defmodule Lisztomania.PlaylistController do
  use Lisztomania.Web, :controller
  plug Lisztomania.Plugs.Auth

  def index(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

  def create(conn, %{"playlist" => playlist_params}) do
    render conn, "errors.json", message: "oops"
  end

  def show(conn, %{"id" => user}) do
    case Spotify.Playlist.get_users_playlists(conn, "mconz") do 
      { :ok, playlists } -> 
        render(conn, "show.json", playlists: playlists 
        )
      { :error, reason } -> 
        { conn, "/error"} 
    end
  end

  def update(conn, %{"id" => id, "playlist" => playlist_params}) do
    render conn, "errors.json", message: "oops"
  end

  def delete(conn, %{"id" => id}) do
    render conn, "errors.json", message: "oops"
  end
end
