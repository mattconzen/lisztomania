require IEx
defmodule Lisztomania.Plugs.Auth do

  def init(default), do: default

  def call(conn, _default) do
    conn = Plug.Conn.fetch_session(conn)
    unless Plug.Conn.get_session(conn, :access_token) do
      Phoenix.Controller.redirect conn, external: SpotifyStrategy.authorize_url!
    else
      IEx.pry
      Map.put(
        conn,
        :params,
        Map.put(conn.params, :code, Plug.Conn.get_session(conn, :access_token))
      )
    end
  end
end
