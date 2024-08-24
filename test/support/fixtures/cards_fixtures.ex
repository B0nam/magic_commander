defmodule MagicCommander.CardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicCommander.Cards` context.
  """

  @doc """
  Generate a card.
  """
  def card_fixture(attrs \\ %{}) do
    {:ok, card} =
      attrs
      |> Enum.into(%{
        cmc: 42,
        color_identity: ["option1", "option2"],
        is_commander: true,
        legal_in_commander: true,
        magic_card_id: "some magic_card_id",
        mana_cost: "some mana_cost",
        name: "some name",
        oracle_text: "some oracle_text",
        power: "some power",
        rarity: "some rarity",
        set_name: "some set_name",
        toughness: "some toughness",
        type_line: "some type_line"
      })
      |> MagicCommander.Cards.create_card()

    card
  end
end
