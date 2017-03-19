require IEx
defmodule Lisztomania.PlaylistController do
  use Lisztomania.Web, :controller
  plug Lisztomania.Plugs.Auth
  alias Spotify.Playlist
  alias Spotify.Album

  def index(conn, %{"user_id" => user_id}) do
    auth = get_credentials(conn)
    IEx.pry
    case Playlist.get_users_playlists(auth, user_id) do
      {:ok, response} ->
        render(conn, "show.json", playlists: response.items)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

  def create(conn, %{"user_id" => user_id, "name" => name}) do
    case Playlist.create_playlist(
      conn,
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
    body = Poison.encode!(%{uris: get_track_ids_for_album(conn, album_id)})
    case Playlist.add_tracks(conn, user_id, playlist_id, body, []) do
      {:ok, _response} ->
        render(conn, "show.json", playlist_id: playlist_id)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

# body = Poison.encode!(%{ uris: [ "spotify:track:755MBpLqJqCO87PkoyBBQC", "spotify:track:1hsWu8gT2We6OzjhYGAged" ]})

  def get_track_ids_for_album(conn, album_id) do
    case Album.get_album_tracks(conn, album_id) do
      {:ok, response} ->
        Enum.into(response.items, [], fn t -> t.uri end)
      {:error, message} ->
        render(conn, "errors.json", message: message)
    end
  end

  def delete(conn, _params) do
    render conn, "errors.json", message: "oops"
  end

  def get_credentials(conn) do
    fetch_session(conn)
    %Spotify.Credentials{
      access_token: get_session(conn, :access_token),
      refresh_token: get_session(conn, :refresh_token)
    }
  end
end
