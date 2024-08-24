defmodule MagicCommander.DeckCards do
  @moduledoc """
  The DeckCards context.
  """

  import Ecto.Query, warn: false
  alias MagicCommander.Repo

  alias MagicCommander.DeckCards.DeckCard

  @doc """
  Returns the list of deck_cards.

  ## Examples

      iex> list_deck_cards()
      [%DeckCard{}, ...]

  """
  def list_deck_cards do
    Repo.all(DeckCard)
  end

  @doc """
  Gets a single deck_card.

  Raises `Ecto.NoResultsError` if the Deck card does not exist.

  ## Examples

      iex> get_deck_card!(123)
      %DeckCard{}

      iex> get_deck_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deck_card!(id), do: Repo.get!(DeckCard, id)

  @doc """
  Creates a deck_card.

  ## Examples

      iex> create_deck_card(%{field: value})
      {:ok, %DeckCard{}}

      iex> create_deck_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deck_card(attrs \\ %{}) do
    %DeckCard{}
    |> DeckCard.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deck_card.

  ## Examples

      iex> update_deck_card(deck_card, %{field: new_value})
      {:ok, %DeckCard{}}

      iex> update_deck_card(deck_card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deck_card(%DeckCard{} = deck_card, attrs) do
    deck_card
    |> DeckCard.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deck_card.

  ## Examples

      iex> delete_deck_card(deck_card)
      {:ok, %DeckCard{}}

      iex> delete_deck_card(deck_card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deck_card(%DeckCard{} = deck_card) do
    Repo.delete(deck_card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deck_card changes.

  ## Examples

      iex> change_deck_card(deck_card)
      %Ecto.Changeset{data: %DeckCard{}}

  """
  def change_deck_card(%DeckCard{} = deck_card, attrs \\ %{}) do
    DeckCard.changeset(deck_card, attrs)
  end
end
