defmodule Lisztomania.PlaylistView do
  use Lisztomania.Web, :view

  def render("index.json", %{playlists: playlists}) do
    %{data: render_many(playlists, Lisztomania.PlaylistView, "playlist.json")}
  end

  def render("show.json", %{playlist: playlist}) do
    %{data: render_one(playlist, Lisztomania.PlaylistView, "playlist.json")}
  end

  def render("playlist.json", %{playlist: playlist}) do
    %{id: playlist.id,
      user_id: playlist.user_id,
      playlist_id: playlist.playlist_id}
  end
end
