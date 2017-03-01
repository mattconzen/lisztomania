defmodule Lisztomania.Plugs.Auth do
  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    if Spotify.Authentication.authenticated?(conn) do
      conn
    else
      Phoenix.Controller.redirect conn, external: Spotify.Authorization.url
    end
  end
end
