defmodule MagicCommanderWeb.CardControllerTest do
  use MagicCommanderWeb.ConnCase

  import MagicCommander.CardsFixtures

  alias MagicCommander.Cards.Card

  @create_attrs %{
    name: "some name",
    magic_card_id: "some magic_card_id",
    mana_cost: "some mana_cost",
    cmc: 42,
    type_line: "some type_line",
    oracle_text: "some oracle_text",
    power: "some power",
    toughness: "some toughness",
    color_identity: ["option1", "option2"],
    legal_in_commander: true,
    set_name: "some set_name",
    rarity: "some rarity",
    is_commander: true
  }
  @update_attrs %{
    name: "some updated name",
    magic_card_id: "some updated magic_card_id",
    mana_cost: "some updated mana_cost",
    cmc: 43,
    type_line: "some updated type_line",
    oracle_text: "some updated oracle_text",
    power: "some updated power",
    toughness: "some updated toughness",
    color_identity: ["option1"],
    legal_in_commander: false,
    set_name: "some updated set_name",
    rarity: "some updated rarity",
    is_commander: false
  }
  @invalid_attrs %{name: nil, magic_card_id: nil, mana_cost: nil, cmc: nil, type_line: nil, oracle_text: nil, power: nil, toughness: nil, color_identity: nil, legal_in_commander: nil, set_name: nil, rarity: nil, is_commander: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all cards", %{conn: conn} do
      conn = get(conn, ~p"/api/cards")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create card" do
    test "renders card when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/cards", card: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/cards/#{id}")

      assert %{
               "id" => ^id,
               "cmc" => 42,
               "color_identity" => ["option1", "option2"],
               "is_commander" => true,
               "legal_in_commander" => true,
               "magic_card_id" => "some magic_card_id",
               "mana_cost" => "some mana_cost",
               "name" => "some name",
               "oracle_text" => "some oracle_text",
               "power" => "some power",
               "rarity" => "some rarity",
               "set_name" => "some set_name",
               "toughness" => "some toughness",
               "type_line" => "some type_line"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/cards", card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update card" do
    setup [:create_card]

    test "renders card when data is valid", %{conn: conn, card: %Card{id: id} = card} do
      conn = put(conn, ~p"/api/cards/#{card}", card: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/cards/#{id}")

      assert %{
               "id" => ^id,
               "cmc" => 43,
               "color_identity" => ["option1"],
               "is_commander" => false,
               "legal_in_commander" => false,
               "magic_card_id" => "some updated magic_card_id",
               "mana_cost" => "some updated mana_cost",
               "name" => "some updated name",
               "oracle_text" => "some updated oracle_text",
               "power" => "some updated power",
               "rarity" => "some updated rarity",
               "set_name" => "some updated set_name",
               "toughness" => "some updated toughness",
               "type_line" => "some updated type_line"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, card: card} do
      conn = put(conn, ~p"/api/cards/#{card}", card: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete card" do
    setup [:create_card]

    test "deletes chosen card", %{conn: conn, card: card} do
      conn = delete(conn, ~p"/api/cards/#{card}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/cards/#{card}")
      end
    end
  end

  defp create_card(_) do
    card = card_fixture()
    %{card: card}
  end
end
