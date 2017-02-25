defmodule Lisztomania.PlaylistView do
  use Lisztomania.Web, :view

  def render("index.json", %{playlists: playlists}) do
    %{data: render_many(playlists, Lisztomania.PlaylistView, "playlist.json")}
  end

  def render("show.json", %{playlists: playlists}) do
    %{
      playlists: Enum.map(playlists, &playlist_json/1)
    }
  end

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.id,
      user_id: playlist.user_id,
      playlist_id: playlist.playlist_id}
  end

  def playlist_json(playlist) do
    %{
      name: playlist.name
    }
  end
end
