require IEx
defmodule Lisztomania.PlaylistController do
  use Lisztomania.Web, :controller
  #  plug Lisztomania.Plugs.Auth

  def index(conn, %{"user_id" => user_id}) do
    IEx.pry
    case Spotify.Playlist.get_users_playlists(conn, user_id) do 
      {:ok, response} -> 
        render(conn, "show.json", playlists: response.items)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

  def create(conn, %{"user_id" => user_id, "name" => name}) do
    case Spotify.Playlist.create_playlist(conn, user_id, Poison.encode!(%{name: name})) do
      {:ok, new_playlist} ->
        render(conn, "show.json", playlist: new_playlist)
      {:error, message} ->
        render(conn, "errors.json", message: "oops")
    end
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
