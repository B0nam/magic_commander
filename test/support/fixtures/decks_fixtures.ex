defmodule MagicCommander.DecksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicCommander.Decks` context.
  """

  @doc """
  Generate a deck.
  """
  def deck_fixture(attrs \\ %{}) do
    {:ok, deck} =
      attrs
      |> Enum.into(%{
        commander_card_id: "7488a646-e31f-11e4-aace-600308960662",
        commander_name: "some commander_name",
        name: "some name"
      })
      |> MagicCommander.Decks.create_deck()

    deck
  end
end
