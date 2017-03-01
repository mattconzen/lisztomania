defmodule Lisztomania.AuthenticationController do 
  use Lisztomania.Web, :controller

  def authenticate(conn, params) do 
    {conn, path} = case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} -> 
        conn = put_status(conn, 301)
        {conn, user_path(conn, :index)}
      {:error, reason, conn} -> 
        {conn, "/error"} 
    end

    redirect conn, to: path
  end
end
