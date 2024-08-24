defmodule MagicCommander.DeckCardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicCommander.DeckCards` context.
  """

  @doc """
  Generate a deck_card.
  """
  def deck_card_fixture(attrs \\ %{}) do
    {:ok, deck_card} =
      attrs
      |> Enum.into(%{
        card_id: "7488a646-e31f-11e4-aace-600308960662",
        deck_id: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> MagicCommander.DeckCards.create_deck_card()

    deck_card
  end
end
