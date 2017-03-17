require IEx
defmodule Lisztomania.AuthenticationController do
  use Lisztomania.Web, :controller

# client = GitHub.get_token!(code: code)
# user = OAuth2.Client.get!(client, "/user").body

# # Or
# case OAuth2.Client.get(client, "/user") do
#   {:ok, %OAuth2.Response{body: user}} ->
#     user
#   {:error, %OAuth2.Response{status_code: 401, body: body}} ->
#     Logger.error("Unauthorized token")
#   {:error, %OAuth2.Error{reason: reason}} ->
#     Logger.error("Error: #{inspect reason}")
# end


  def authenticate(conn, params) do
    IEx.pry
    client = SpotifyStrategy.get_token!(code: params["code"])
    conn
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end
end
