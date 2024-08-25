defmodule MagicCommander.Cards.Card do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "cards" do
    field :name, :string
    field :magic_card_id, :string
    field :mana_cost, :string
    field :cmc, :float
    field :type_line, :string
    field :oracle_text, :string
    field :power, :string
    field :toughness, :string
    field :color_identity, {:array, :string}
    field :legal_in_commander, :boolean, default: false
    field :set_name, :string
    field :rarity, :string
    field :is_commander, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:magic_card_id, :name, :mana_cost, :cmc, :type_line, :oracle_text, :power, :toughness, :color_identity, :legal_in_commander, :set_name, :rarity, :is_commander])
    |> validate_required([:magic_card_id, :name, :type_line, :oracle_text, :color_identity, :legal_in_commander, :set_name, :rarity, :is_commander])
  end
end
