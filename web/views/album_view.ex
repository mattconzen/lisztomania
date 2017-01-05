defmodule Lisztomania.AlbumView do
  use Lisztomania.Web, :view

  def render("index.json", %{albums: albums}) do
    %{data: render_many(albums, Lisztomania.AlbumView, "album.json")}
  end

  def render("show.json", %{album: album}) do
    %{data: render_one(album, Lisztomania.AlbumView, "album.json")}
  end

  def render("album.json", %{album: album}) do
    %{id: album.id,
      name: album.name,
      artist: album.artist}
  end
end
