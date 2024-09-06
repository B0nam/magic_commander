defmodule MagicCommanderWeb.DeckCardController do
  use MagicCommanderWeb, :controller

  alias MagicCommander.DeckCards
  alias MagicCommander.DeckCards.DeckCard

  action_fallback MagicCommanderWeb.FallbackController

  def index(conn, _params) do
    deck_cards = DeckCards.list_deck_cards()
    render(conn, :index, deck_cards: deck_cards)
  end

  def show(conn, %{"id" => id}) do
    deck_card = DeckCards.get_deck_card!(id)
    render(conn, :show, deck_card: deck_card)
  end

  def update(conn, %{"id" => id, "deck_card" => deck_card_params}) do
    deck_card = DeckCards.get_deck_card!(id)

    with {:ok, %DeckCard{} = deck_card} <- DeckCards.update_deck_card(deck_card, deck_card_params) do
      render(conn, :show, deck_card: deck_card)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck_card = DeckCards.get_deck_card!(id)

    with {:ok, %DeckCard{}} <- DeckCards.delete_deck_card(deck_card) do
      send_resp(conn, :no_content, "")
    end
  end
end
