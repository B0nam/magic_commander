defmodule MagicCommander.DecksTest do
  use MagicCommander.DataCase

  alias MagicCommander.Decks

  describe "decks" do
    alias MagicCommander.Decks.Deck

    import MagicCommander.DecksFixtures

    @invalid_attrs %{name: nil, commander_name: nil, commander_card_id: nil}

    test "list_decks/0 returns all decks" do
      assert Decks.list_decks() != nil
    end

    test "create_deck/1 with valid data creates a deck" do
      valid_attrs = %{name: "teste", commander_name: "teste"}

      assert Decks.create_deck(valid_attrs) != nil
    end

    test "create_deck/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Decks.create_deck(@invalid_attrs)
    end

    test "update_deck/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} != nil
    end

  end
end
