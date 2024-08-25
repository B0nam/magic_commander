defmodule MagicCommander.ApiClient do
  alias MagicCommander.CardFormatter
  use HTTPoison.Base

  @magic_api_url "https://api.scryfall.com"

  def get_card_by_name(name) do
    url = "#{@magic_api_url}/cards/named?exact=#{URI.encode(name)}"

    case fetch_data(url) do
      {:ok, card_data} ->
        formatted_card_data = CardFormatter.format_card(card_data)
        {:ok, formatted_card_data}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def get_cards_by_commander(name) do
    case get_card_by_name(name) do
      {:ok, commander_card} ->
        if commander_card[:legal_in_commander] do
          color_identity = commander_card[:color_identity]

          url =
            "#{@magic_api_url}/cards/search?q=color:" <>
              Enum.join(color_identity, "+OR+") <> "&unique=cards"

          case fetch_data(url) do
            {:ok, %{"data" => cards}} ->
              formatted_cards = Enum.map(cards, &CardFormatter.format_card/1)
              {:ok, formatted_cards}

            {:error, reason} ->
              {:error, reason}
          end
        else
          {:error, "Commander is not legal in Commander format."}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp fetch_data(url) do
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        card_data = Poison.decode!(body)
        {:ok, card_data}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Error fetching card. Status code: #{status_code}, Response Body: #{body}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "Request failed. Reason: #{reason}"}
    end
  end
end
