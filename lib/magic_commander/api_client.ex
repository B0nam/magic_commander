defmodule MagicCommander.ApiClient do
  alias MagicCommander.CardFormatter
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
        {:ok, CardFormatter.format_card(card_data)}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Error fetching card. Status code: #{status_code}, Response Body: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed. Reason: #{reason}"}
    end
  end
end
