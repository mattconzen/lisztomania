defmodule Lisztomania.GetAuth do
  import Plug.Conn

  def get_credentials(conn) do
    fetch_session(conn)
    %Spotify.Credentials{
      access_token: get_session(conn, :access_token),
      refresh_token: get_session(conn, :refresh_token)
    }
  end

end