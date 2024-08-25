defmodule MagicCommanderWeb.DeckController do
  use MagicCommanderWeb, :controller

  alias MagicCommander.Decks
  alias MagicCommander.Decks.Deck
  alias MagicCommander.Cards
  alias MagicCommander.Cards.Card
  alias MagicCommander.ApiClient

  action_fallback MagicCommanderWeb.FallbackController

  def index(conn, _params) do
    decks = Decks.list_decks()
    render(conn, :index, decks: decks)
  end

  def create(conn, deck_params) do
    case ApiClient.get_card_by_name(deck_params["commander_name"]) do
      {:ok, card_data} ->
        if card_data[:legal_in_commander] do
          updated_card_data = Map.put(card_data, :is_commander, true)

          with {:ok, %Card{} = commander_card} <- Cards.create_card(updated_card_data),
               deck_params <-
                 Map.put(deck_params, "commander_card_id", commander_card.id),
               {:ok, %Deck{} = deck} <- Decks.create_deck(deck_params) do
            conn
            |> put_status(:created)
            |> put_resp_content_type("application/json")
            |> json(%{message: "Success to create new deck!", deck: deck.id})
          else
            {:error, reason} ->
              conn
              |> put_status(:unprocessable_entity)
              |> json(%{error: "Failed to create deck: #{reason}"})
          end
        else
          conn
          |> put_status(:unprocessable_entity)
          |> json(%{error: "#{deck_params["commander_name"]} cannot be used as a commander."})
        end

      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Commander not found: #{reason}"})
    end
  end

  def show(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)
    render(conn, :show, deck: deck)
  end

  def update(conn, %{"id" => id, "deck" => deck_params}) do
    deck = Decks.get_deck!(id)

    with {:ok, %Deck{} = deck} <- Decks.update_deck(deck, deck_params) do
      render(conn, :show, deck: deck)
    end
  end

  def delete(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)

    with {:ok, %Deck{}} <- Decks.delete_deck(deck) do
      send_resp(conn, :no_content, "")
    end
  end
end
