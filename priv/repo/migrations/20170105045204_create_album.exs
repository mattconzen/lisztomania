defmodule Lisztomania.Repo.Migrations.CreateAlbum do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :artist, :string

      timestamps()
    end

  end
end
