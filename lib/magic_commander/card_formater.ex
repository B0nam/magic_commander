defmodule MagicCommander.CardFormatter do
  def format_card(card_data) do
    %{
      magic_card_id: card_data["id"],
      name: card_data["name"],
      mana_cost: card_data["mana_cost"],
      cmc: card_data["cmc"],
      type_line: card_data["type_line"],
      oracle_text: card_data["oracle_text"],
      power: card_data["power"],
      toughness: card_data["toughness"],
      color_identity: card_data["color_identity"],
      legal_in_commander: card_data["legalities"]["commander"] in ["legal", "restricted"],
      set_name: card_data["set_name"],
      rarity: card_data["rarity"],
      is_commander: card_data["is_commander"] || false
    }
  end
end
