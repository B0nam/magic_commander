defmodule MagicCommanderWeb.DeckCardJSON do
  alias MagicCommander.DeckCards.DeckCard

  @doc """
  Renders a list of deck_cards.
  """
  def index(%{deck_cards: deck_cards}) do
    %{data: for(deck_card <- deck_cards, do: data(deck_card))}
  end

  @doc """
  Renders a single deck_card.
  """
  def show(%{deck_card: deck_card}) do
    %{data: data(deck_card)}
  end

  defp data(%DeckCard{} = deck_card) do
    %{
      id: deck_card.id,
      deck_id: deck_card.deck_id,
      card_id: deck_card.card_id
    }
  end
end
