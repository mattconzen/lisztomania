use Mix.Config

config :spotify_ex, scopes: ["playlist-read-private",
                             "playlist-modify-private"
                            ],
                    callback_url: "http://127.0.0.1:4000/authenticate"
