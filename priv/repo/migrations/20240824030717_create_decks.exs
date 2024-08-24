defmodule MagicCommander.Repo.Migrations.CreateDecks do
  use Ecto.Migration

  def change do
    create table(:decks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :commander_name, :string
      add :commander_card_id, references(:cards, type: :binary_id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:decks, [:commander_card_id])
  end
end
