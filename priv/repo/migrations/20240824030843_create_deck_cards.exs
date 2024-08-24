defmodule MagicCommander.Repo.Migrations.CreateDeckCards do
  use Ecto.Migration

  def change do
    create table(:deck_cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :deck_id, references(:decks, type: :binary_id, on_delete: :delete_all)
      add :card_id, references(:cards, type: :binary_id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:deck_cards, [:deck_id])
    create index(:deck_cards, [:card_id])
  end
end
