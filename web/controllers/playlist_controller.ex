defmodule Lisztomania.PlaylistController do
  use Lisztomania.Web, :controller
  import Lisztomania.GetAuth
  plug Lisztomania.Plugs.Auth
  alias Spotify.Playlist
  alias Spotify.Album

  def index(conn, %{"user_id" => user_id}) do
    auth = get_credentials(conn)
    case Playlist.get_users_playlists(auth, user_id) do
      {:ok, response} ->
        render(conn, "show.json", playlists: response.items)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

  def create(conn, %{"user_id" => user_id, "name" => name}) do
    auth = get_credentials(conn)
    case Playlist.create_playlist(
      auth,
      user_id,
      Poison.encode!(%{name: name})
    ) do
      {:ok, new_playlist} ->
        render(conn, "show.json", playlist: new_playlist)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

  def show(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

  def update(conn, %{"user_id" => user_id, "id" => playlist_id, "album_id" => album_id}) do
    auth = get_credentials(conn)
    body = Poison.encode!(%{uris: get_track_ids_for_album(auth, album_id)})
    case Playlist.add_tracks(auth, user_id, playlist_id, body, []) do
      {:ok, _response} ->
        render(conn, "show.json", playlist_id: playlist_id)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

# body = Poison.encode!(%{ uris: [ "spotify:track:755MBpLqJqCO87PkoyBBQC", "spotify:track:1hsWu8gT2We6OzjhYGAged" ]})

  def get_track_ids_for_album(auth, album_id) do
    case Album.get_album_tracks(auth, album_id) do
      {:ok, response} ->
        Enum.into(response.items, [], fn t -> t.uri end)
      {:error, message} ->
        {:error, message}
    end
  end

  def delete(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

end
