defmodule MagicCommanderWeb.DeckController do
  use MagicCommanderWeb, :controller

  alias MagicCommander.CardFormatter
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

  def populate(conn, %{"id" => id}) do
    deck = Decks.get_deck!(id)

    case ApiClient.get_cards_by_commander(deck.commander_name) do
      {:ok, cards} ->
        Decks.remove_cards_from_deck(id)

        Enum.each(cards, fn card ->
          case Cards.create_card(card) do
            {:ok, new_card} ->
              Decks.add_card_to_deck(id, new_card.id)

            {:error, changeset} ->
              IO.puts("Error creating card: #{inspect(changeset.errors)}")
          end
        end)

        case Decks.get_deck_with_cards(id) do
          {:ok, _updated_deck} ->
            conn
            |> put_status(:ok)
            |> put_resp_content_type("application/json")
            |> json(%{message: "Success to populate deck!", deck: id})

          {:error, reason} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: reason})
        end

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end

  def export(conn, %{"id" => id}) do
    case Decks.get_deck_with_cards(id) do
      {:ok, deck} ->
        formatted_cards =
          deck.cards
          |> Enum.map(&CardFormatter.format_card_to_export/1)

        conn
        |> put_status(:ok)
        |> put_resp_content_type("application/json")
        |> json(%{cards: formatted_cards})

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end
end
