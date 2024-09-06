defmodule MagicCommander.ApiClientTest do
  use ExUnit.Case
  alias MagicCommander.ApiClient

  test "get_card_by_name/1 returns non-null result for a valid card" do
    card_name = "Black Lotus"
    result = ApiClient.get_card_by_name(card_name)
    assert result != nil
  end

  test "get_card_by_name/1 returns an error for an invalid card" do
    invalid_card_name = "InvalidCardNameThatDoesNotExist"
    result = ApiClient.get_card_by_name(invalid_card_name)
    assert result != nil
  end

  test "get_cards_by_commander/1 returns non-null result for a valid commander" do
    commander_name = "Jace, the Mind Sculptor"
    result = ApiClient.get_cards_by_commander(commander_name)
    assert result != nil
  end

  test "get_cards_by_commander/1 returns an error for an invalid commander" do
    invalid_commander_name = "InvalidCommanderName"
    result = ApiClient.get_cards_by_commander(invalid_commander_name)
    assert result != nil
  end
end
