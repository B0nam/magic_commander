defmodule MagicCommander.DeckCardsTest do
  use MagicCommander.DataCase

  alias MagicCommander.DeckCards

  describe "deck_cards" do
    alias MagicCommander.DeckCards.DeckCard

    import MagicCommander.DeckCardsFixtures

    @invalid_attrs %{deck_id: nil, card_id: nil}

    test "list_deck_cards/0 returns all deck_cards" do
      deck_card = deck_card_fixture()
      assert DeckCards.list_deck_cards() == [deck_card]
    end

    test "get_deck_card!/1 returns the deck_card with given id" do
      deck_card = deck_card_fixture()
      assert DeckCards.get_deck_card!(deck_card.id) == deck_card
    end

    test "create_deck_card/1 with valid data creates a deck_card" do
      valid_attrs = %{deck_id: "7488a646-e31f-11e4-aace-600308960662", card_id: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %DeckCard{} = deck_card} = DeckCards.create_deck_card(valid_attrs)
      assert deck_card.deck_id == "7488a646-e31f-11e4-aace-600308960662"
      assert deck_card.card_id == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_deck_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DeckCards.create_deck_card(@invalid_attrs)
    end

    test "update_deck_card/2 with valid data updates the deck_card" do
      deck_card = deck_card_fixture()
      update_attrs = %{deck_id: "7488a646-e31f-11e4-aace-600308960668", card_id: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %DeckCard{} = deck_card} = DeckCards.update_deck_card(deck_card, update_attrs)
      assert deck_card.deck_id == "7488a646-e31f-11e4-aace-600308960668"
      assert deck_card.card_id == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_deck_card/2 with invalid data returns error changeset" do
      deck_card = deck_card_fixture()
      assert {:error, %Ecto.Changeset{}} = DeckCards.update_deck_card(deck_card, @invalid_attrs)
      assert deck_card == DeckCards.get_deck_card!(deck_card.id)
    end

    test "delete_deck_card/1 deletes the deck_card" do
      deck_card = deck_card_fixture()
      assert {:ok, %DeckCard{}} = DeckCards.delete_deck_card(deck_card)
      assert_raise Ecto.NoResultsError, fn -> DeckCards.get_deck_card!(deck_card.id) end
    end

    test "change_deck_card/1 returns a deck_card changeset" do
      deck_card = deck_card_fixture()
      assert %Ecto.Changeset{} = DeckCards.change_deck_card(deck_card)
    end
  end
end
