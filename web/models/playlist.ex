defmodule Lisztomania.Playlist do
  use Lisztomania.Web, :model

  schema "playlists" do
    field :user_id, :string
    field :playlist_id, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :playlist_id])
    |> validate_required([:user_id, :playlist_id])
  end
end
