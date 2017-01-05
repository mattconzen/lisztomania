defmodule Lisztomania.Album do
  use Lisztomania.Web, :model

  schema "albums" do
    field :name, :string
    field :artist, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :artist])
    |> validate_required([:name, :artist])
  end
end
