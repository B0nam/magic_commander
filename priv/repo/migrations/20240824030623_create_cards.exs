defmodule MagicCommander.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :magic_card_id, :string
      add :name, :string
      add :mana_cost, :string
      add :cmc, :float
      add :type_line, :string
      add :oracle_text, :text
      add :power, :string
      add :toughness, :string
      add :color_identity, {:array, :string}
      add :legal_in_commander, :boolean, default: false, null: false
      add :set_name, :string
      add :rarity, :string
      add :is_commander, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
