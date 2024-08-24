defmodule MagicCommanderWeb.DeckCardControllerTest do
  use MagicCommanderWeb.ConnCase

  import MagicCommander.DeckCardsFixtures

  alias MagicCommander.DeckCards.DeckCard

  @create_attrs %{
    deck_id: "7488a646-e31f-11e4-aace-600308960662",
    card_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    deck_id: "7488a646-e31f-11e4-aace-600308960668",
    card_id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{deck_id: nil, card_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all deck_cards", %{conn: conn} do
      conn = get(conn, ~p"/api/deck_cards")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create deck_card" do
    test "renders deck_card when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/deck_cards", deck_card: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/deck_cards/#{id}")

      assert %{
               "id" => ^id,
               "card_id" => "7488a646-e31f-11e4-aace-600308960662",
               "deck_id" => "7488a646-e31f-11e4-aace-600308960662"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/deck_cards", deck_card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update deck_card" do
    setup [:create_deck_card]

    test "renders deck_card when data is valid", %{conn: conn, deck_card: %DeckCard{id: id} = deck_card} do
      conn = put(conn, ~p"/api/deck_cards/#{deck_card}", deck_card: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/deck_cards/#{id}")

      assert %{
               "id" => ^id,
               "card_id" => "7488a646-e31f-11e4-aace-600308960668",
               "deck_id" => "7488a646-e31f-11e4-aace-600308960668"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, deck_card: deck_card} do
      conn = put(conn, ~p"/api/deck_cards/#{deck_card}", deck_card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete deck_card" do
    setup [:create_deck_card]

    test "deletes chosen deck_card", %{conn: conn, deck_card: deck_card} do
      conn = delete(conn, ~p"/api/deck_cards/#{deck_card}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/deck_cards/#{deck_card}")
      end
    end
  end

  defp create_deck_card(_) do
    deck_card = deck_card_fixture()
    %{deck_card: deck_card}
  end
end
