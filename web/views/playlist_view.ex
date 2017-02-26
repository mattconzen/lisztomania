defmodule Lisztomania.PlaylistView do
  use Lisztomania.Web, :view

  def render("errors.json", %{message: message}) do
    message
  end

  def render("show.json", %{playlists: playlists}) do
    %{  
      playlists: Enum.map(playlists, &playlist_json/1)
    }
  end

  def playlist_json(playlist) do
    %{
      name: playlist.name
    }
  end

end
