defmodule MagicCommander.ApiClient do
  use HTTPoison.Base

  @magic_api_url "https://api.scryfall.com"

  def get_card_by_name(name) do
    url = "#{@magic_api_url}/cards/named?exact=#{URI.encode(name)}"

    fetch_data(url)
  end

  defp fetch_data(url) do
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        card_data = Poison.decode!(body)
        {:ok, format_card(card_data)}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Error fetching card. Status code: #{status_code}, Response Body: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed. Reason: #{reason}"}
    end
  end

  defp format_card(card_data) do
    %{
      id: card_data["id"],
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
      rarity: card_data["rarity"]
    }
  end
end
