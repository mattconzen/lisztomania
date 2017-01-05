defmodule Lisztomania.AlbumControllerTest do
  use Lisztomania.ConnCase

  alias Lisztomania.Album
  @valid_attrs %{artist: "some content", name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, album_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    album = Repo.insert! %Album{}
    conn = get conn, album_path(conn, :show, album)
    assert json_response(conn, 200)["data"] == %{"id" => album.id,
      "name" => album.name,
      "artist" => album.artist}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, album_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, album_path(conn, :create), album: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Album, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, album_path(conn, :create), album: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    album = Repo.insert! %Album{}
    conn = put conn, album_path(conn, :update, album), album: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Album, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    album = Repo.insert! %Album{}
    conn = put conn, album_path(conn, :update, album), album: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    album = Repo.insert! %Album{}
    conn = delete conn, album_path(conn, :delete, album)
    assert response(conn, 204)
    refute Repo.get(Album, album.id)
  end
end
