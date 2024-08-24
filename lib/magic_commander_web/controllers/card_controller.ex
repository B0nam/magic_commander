defmodule MagicCommanderWeb.CardController do
  use MagicCommanderWeb, :controller

  alias MagicCommander.ApiClient
  alias MagicCommander.Cards
  alias MagicCommander.Cards.Card

  action_fallback MagicCommanderWeb.FallbackController

  def index(conn, _params) do
    cards = Cards.list_cards()
    render(conn, :index, cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    with {:ok, %Card{} = card} <- Cards.create_card(card_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/cards/#{card}")
      |> render(:show, card: card)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Cards.get_card!(id)
    render(conn, :show, card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Cards.get_card!(id)

    with {:ok, %Card{} = card} <- Cards.update_card(card, card_params) do
      render(conn, :show, card: card)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Cards.get_card!(id)

    with {:ok, %Card{}} <- Cards.delete_card(card) do
      send_resp(conn, :no_content, "")
    end
  end

  def find(conn, %{"name" => name}) do
    case ApiClient.get_card_by_name(name) do
      {:ok, card} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:ok, Jason.encode!(card))

      {:error, reason} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:bad_request, Jason.encode!(%{error: reason}))
    end
  end
end
