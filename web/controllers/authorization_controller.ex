defmodule Lisztomania.AuthorizationController do
  use Lisztomania.Web, :controller

  def authorize(conn, _params) do
    redirect conn, external: SpotifyStrategy.authorize_url!
  end
end
