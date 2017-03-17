defmodule SpotifyStrategy do
    use OAuth2.Strategy

    def client do
        OAuth2.Client.new([
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
        OAuth2.Client.authorize_url!(
            client(),
            scope: "playlist-read-private playlist-modify-public playlist-modify-private"
        )
    end

    def get_token!(params \\ [], headers \\ [], opts \\ []) do
        OAuth2.Client.get_token!(client(), params, headers, opts)
    end

    def authorize_url(client, params) do
        OAuth2.Strategy.AuthCode.authorize_url(client, params)
    end

    def get_token(client, params, headers) do
        client
        |> put_param(:client_secret, client.client_secret)
        |> put_header("accept", "application/json")
        |> OAuth2.Strategy.AuthCode.get_token(params, headers)
    end
end