require IEx 
defmodule Lisztomania.PlaylistController do
  use Lisztomania.Web, :controller
  plug Lisztomania.Plugs.Auth

  def index(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

  def create(conn, %{"user" => user, "name" => playlist_id}) do
    case Spotify.Playlist.create_playlist(conn, user, playlist_id) do
      { :ok, response } ->
        render(conn, "show.json", playlists: response)
      { :error, message } ->
        render(conn, "errors.json", message: message)
    end
  end

  def show(conn, %{"id" => user}) do
    case Spotify.Playlist.get_users_playlists(conn, user) do 
      { :ok, response } -> 
        render(conn, "show.json", playlists: response.items)
      { :error, message } ->
        render(conn, "errors.json", message: message)
    end
  end

  def update(conn, %{"id" => id, "playlist" => playlist_params}) do
    render conn, "errors.json", message: "oops"
  end

  def delete(conn, %{"id" => id}) do
    render conn, "errors.json", message: "oops"
  end
end
