defmodule Lisztomania.Repo.Migrations.CreatePlaylist do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :user_id, :string
      add :playlist_id, :string

      timestamps()
    end

  end
end
