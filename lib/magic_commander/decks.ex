defmodule MagicCommander.Decks do
  import Ecto.Query, warn: false
  alias MagicCommander.Repo
  alias MagicCommander.Decks.Deck
  alias MagicCommander.DeckCards.DeckCard
  alias MagicCommander.Cards.Card

  def list_decks do
    Repo.all(Deck)
  end

  def get_deck!(id), do: Repo.get!(Deck, id)

  def get_deck_with_cards(id) do
    deck_query = from(d in Deck, where: d.id == ^id)

    cards_query =
      from(dc in DeckCard,
        join: c in Card,
        on: c.id == dc.card_id,
        where: dc.deck_id == ^id,
        select: c
      )

    case Repo.one(deck_query) do
      nil ->
        {:error, "Deck not found"}

      deck ->
        cards = Repo.all(cards_query)
        {:ok, %{deck: deck, cards: cards}}
    end
  end

  def create_deck(attrs \\ %{}) do
    %Deck{}
    |> Deck.changeset(attrs)
    |> Repo.insert()
  end

  def update_deck(%Deck{} = deck, attrs) do
    deck
    |> Deck.changeset(attrs)
    |> Repo.update()
  end

  def delete_deck(%Deck{} = deck) do
    Repo.delete(deck)
  end

  def change_deck(%Deck{} = deck, attrs \\ %{}) do
    Deck.changeset(deck, attrs)
  end

  def add_card_to_deck(deck_id, card_id) do
    %DeckCard{}
    |> DeckCard.changeset(%{deck_id: deck_id, card_id: card_id})
    |> Repo.insert()
  end

  def remove_cards_from_deck(deck_id) do
    from(dc in DeckCard, where: dc.deck_id == ^deck_id)
    |> Repo.delete_all()
    |> case do
      {count, _} when count >= 0 -> :ok
      _ -> {:error, "Erro ao remover as cartas do deck"}
    end
  end

  def list_cards_for_deck(deck_id) do
    from(dc in DeckCard,
      join: c in Card,
      on: c.id == dc.card_id,
      where: dc.deck_id == ^deck_id,
      select: c
    )
    |> Repo.all()
  end
end
