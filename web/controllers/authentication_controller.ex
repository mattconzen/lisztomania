defmodule Lisztomania.AuthenticationController do
  use Lisztomania.Web, :controller

  def authenticate(conn, params) do
    client = SpotifyStrategy.get_token!(code: params["code"])
    conn
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end
end
