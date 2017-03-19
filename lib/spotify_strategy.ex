defmodule SpotifyStrategy do
    alias OAuth2.Strategy.AuthCode
    alias OAuth2.Client
    @moduledoc """
    Provides an OAuth2 strategy for spotify, implementing the
    pattern suggested by the OAuth2 lib

    for details: https://github.com/scrogson/oauth2
    """

    def client do
        Client.new([
            strategy: __MODULE__,
            client_id: System.get_env("SPOTIFY_CLIENT_ID"),
            client_secret: System.get_env("SPOTIFY_SECRET_KEY"),
            redirect_uri: System.get_env("OAUTH_REDIRECT_URI"),
            site: "https://accounts.spotify.com",
            authorize_url: "https://accounts.spotify.com/authorize",
            token_url: "https://accounts.spotify.com/api/token"
        ])
    end

    def authorize_url! do
        Client.authorize_url!(
            client(),
            scope: "playlist-read-private playlist-modify-public playlist-modify-private"
        )
    end

    def get_token!(params \\ [], headers \\ [], opts \\ []) do
        Client.get_token!(client(), params, headers, opts)
    end

    def authorize_url(client, params) do
        AuthCode.authorize_url(client, params)
    end

    def get_token(client, params, headers) do
        client
        |> Client.put_param(:client_secret, client.client_secret)
        |> Client.put_header("accept", "application/json")
        |> AuthCode.get_token(params, headers)
    end
end
