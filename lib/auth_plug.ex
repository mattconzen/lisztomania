require IEx
defmodule Lisztomania.Plugs.Auth do
  alias SpotifyStrategy
  alias Plug.Conn
  alias Phoenix.Controller
  @moduledoc """
    A plug for validating or initiating spotify user auth
  """

  def init(default), do: default

  def call(conn, _default) do
    conn = Conn.fetch_session(conn)
    if Conn.get_session(conn, :access_token) do
      Map.put(conn, :params, Map.put(
          conn.params,
          :code,
          Conn.get_session(conn, :access_token)
        )
      )
    else
      Controller.redirect(conn, external: SpotifyStrategy.authorize_url!)
    end
  end
end
