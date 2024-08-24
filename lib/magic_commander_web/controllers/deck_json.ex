defmodule MagicCommanderWeb.DeckJSON do
  alias MagicCommander.Decks.Deck

  @doc """
  Renders a list of decks.
  """
  def index(%{decks: decks}) do
    %{data: for(deck <- decks, do: data(deck))}
  end

  @doc """
  Renders a single deck.
  """
  def show(%{deck: deck}) do
    %{data: data(deck)}
  end

  defp data(%Deck{} = deck) do
    %{
      id: deck.id,
      name: deck.name,
      commander_name: deck.commander_name,
      commander_card_id: deck.commander_card_id
    }
  end
end
