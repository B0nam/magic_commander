defmodule MagicCommander.DeckCards.DeckCard do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "deck_cards" do
    field :deck_id, Ecto.UUID
    field :card_id, Ecto.UUID

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(deck_card, attrs) do
    deck_card
    |> cast(attrs, [:deck_id, :card_id])
    |> validate_required([:deck_id, :card_id])
  end
end
