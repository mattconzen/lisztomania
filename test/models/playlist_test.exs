defmodule Lisztomania.PlaylistTest do
  use Lisztomania.ModelCase

  alias Lisztomania.Playlist

  @valid_attrs %{playlist_id: "some content", user_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Playlist.changeset(%Playlist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Playlist.changeset(%Playlist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
