defmodule MagicCommanderWeb.DeckControllerTest do
  use MagicCommanderWeb.ConnCase

  import MagicCommander.DecksFixtures

  alias MagicCommander.Decks.Deck

  @create_attrs %{
    name: "some name",
    commander_name: "some commander_name",
    commander_card_id: "7488a646-e31f-11e4-aace-600308960662"
  }
  @update_attrs %{
    name: "some updated name",
    commander_name: "some updated commander_name",
    commander_card_id: "7488a646-e31f-11e4-aace-600308960668"
  }
  @invalid_attrs %{name: nil, commander_name: nil, commander_card_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all decks", %{conn: conn} do
      conn = get(conn, ~p"/api/decks")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create deck" do
    test "renders deck when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/decks", deck: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/decks/#{id}")

      assert %{
               "id" => ^id,
               "commander_card_id" => "7488a646-e31f-11e4-aace-600308960662",
               "commander_name" => "some commander_name",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/decks", deck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update deck" do
    setup [:create_deck]

    test "renders deck when data is valid", %{conn: conn, deck: %Deck{id: id} = deck} do
      conn = put(conn, ~p"/api/decks/#{deck}", deck: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/decks/#{id}")

      assert %{
               "id" => ^id,
               "commander_card_id" => "7488a646-e31f-11e4-aace-600308960668",
               "commander_name" => "some updated commander_name",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, deck: deck} do
      conn = put(conn, ~p"/api/decks/#{deck}", deck: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete deck" do
    setup [:create_deck]

    test "deletes chosen deck", %{conn: conn, deck: deck} do
      conn = delete(conn, ~p"/api/decks/#{deck}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/decks/#{deck}")
      end
    end
  end

  defp create_deck(_) do
    deck = deck_fixture()
    %{deck: deck}
  end
end
