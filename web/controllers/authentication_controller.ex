defmodule Lisztomania.AuthenticationController do
  use Lisztomania.Web, :controller

  def authenticate(conn, params) do
    client = SpotifyStrategy.get_token!(code: params["code"])
    conn
    |> put_session(:access_token, client.token.access_token)
    |> put_session(:refresh_token, client.token.refresh_token)
    |> redirect(to: "/")
  end
end
