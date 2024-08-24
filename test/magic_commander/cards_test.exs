defmodule MagicCommander.CardsTest do
  use MagicCommander.DataCase

  alias MagicCommander.Cards

  describe "cards" do
    alias MagicCommander.Cards.Card

    import MagicCommander.CardsFixtures

    @invalid_attrs %{name: nil, magic_card_id: nil, mana_cost: nil, cmc: nil, type_line: nil, oracle_text: nil, power: nil, toughness: nil, color_identity: nil, legal_in_commander: nil, set_name: nil, rarity: nil, is_commander: nil}

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Cards.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Cards.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      valid_attrs = %{name: "some name", magic_card_id: "some magic_card_id", mana_cost: "some mana_cost", cmc: 42, type_line: "some type_line", oracle_text: "some oracle_text", power: "some power", toughness: "some toughness", color_identity: ["option1", "option2"], legal_in_commander: true, set_name: "some set_name", rarity: "some rarity", is_commander: true}

      assert {:ok, %Card{} = card} = Cards.create_card(valid_attrs)
      assert card.name == "some name"
      assert card.magic_card_id == "some magic_card_id"
      assert card.mana_cost == "some mana_cost"
      assert card.cmc == 42
      assert card.type_line == "some type_line"
      assert card.oracle_text == "some oracle_text"
      assert card.power == "some power"
      assert card.toughness == "some toughness"
      assert card.color_identity == ["option1", "option2"]
      assert card.legal_in_commander == true
      assert card.set_name == "some set_name"
      assert card.rarity == "some rarity"
      assert card.is_commander == true
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cards.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      update_attrs = %{name: "some updated name", magic_card_id: "some updated magic_card_id", mana_cost: "some updated mana_cost", cmc: 43, type_line: "some updated type_line", oracle_text: "some updated oracle_text", power: "some updated power", toughness: "some updated toughness", color_identity: ["option1"], legal_in_commander: false, set_name: "some updated set_name", rarity: "some updated rarity", is_commander: false}

      assert {:ok, %Card{} = card} = Cards.update_card(card, update_attrs)
      assert card.name == "some updated name"
      assert card.magic_card_id == "some updated magic_card_id"
      assert card.mana_cost == "some updated mana_cost"
      assert card.cmc == 43
      assert card.type_line == "some updated type_line"
      assert card.oracle_text == "some updated oracle_text"
      assert card.power == "some updated power"
      assert card.toughness == "some updated toughness"
      assert card.color_identity == ["option1"]
      assert card.legal_in_commander == false
      assert card.set_name == "some updated set_name"
      assert card.rarity == "some updated rarity"
      assert card.is_commander == false
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Cards.update_card(card, @invalid_attrs)
      assert card == Cards.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Cards.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Cards.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Cards.change_card(card)
    end
  end
end
