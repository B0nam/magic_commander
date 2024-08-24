defmodule MagicCommander.Decks.Deck do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "decks" do
    field :name, :string
    field :commander_name, :string
    field :commander_card_id, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deck, attrs) do
    deck
    |> cast(attrs, [:name, :commander_name, :commander_card_id])
    |> validate_required([:name, :commander_name, :commander_card_id])
  end
end
