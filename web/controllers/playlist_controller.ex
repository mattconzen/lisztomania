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
    playlists = elem(Spotify.Playlist.get_users_playlists(conn, "mconz"), 1).items
    render conn, "show.json", playlists: playlists
  end

  def update(conn, %{"id" => id, "playlist" => playlist_params}) do
    render conn, "errors.json", message: "oops"
  end

  def delete(conn, %{"id" => id}) do
    render conn, "errors.json", message: "oops"
  end
end
