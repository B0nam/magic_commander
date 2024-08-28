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

  def format_card_to_export(card) do
    %{
      "name" => card.name,
      "magic_card_id" => card.magic_card_id,
      "mana_cost" => card.mana_cost,
      "cmc" => card.cmc,
      "type_line" => card.type_line,
      "oracle_text" => card.oracle_text,
      "power" => card.power,
      "toughness" => card.toughness,
      "color_identity" => card.color_identity,
      "legal_in_commander" => card.legal_in_commander,
      "set_name" => card.set_name,
      "rarity" => card.rarity,
      "is_commander" => card.is_commander
    }
  end
end
