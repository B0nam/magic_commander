defmodule MagicCommanderWeb.CardJSON do
  alias MagicCommander.Cards.Card

  @doc """
  Renders a list of cards.
  """
  def index(%{cards: cards}) do
    %{data: for(card <- cards, do: data(card))}
  end

  @doc """
  Renders a single card.
  """
  def show(%{card: card}) do
    %{data: data(card)}
  end

  defp data(%Card{} = card) do
    %{
      id: card.id,
      magic_card_id: card.magic_card_id,
      name: card.name,
      mana_cost: card.mana_cost,
      cmc: card.cmc,
      type_line: card.type_line,
      oracle_text: card.oracle_text,
      power: card.power,
      toughness: card.toughness,
      color_identity: card.color_identity,
      legal_in_commander: card.legal_in_commander,
      set_name: card.set_name,
      rarity: card.rarity,
      is_commander: card.is_commander
    }
  end
end
