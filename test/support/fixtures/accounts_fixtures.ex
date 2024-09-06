defmodule MagicCommander.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MagicCommander.Accounts` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "teste@teste.com",
        hash_password: "hashpasswd"
      })
      |> MagicCommander.Accounts.create_account()

    account
  end
end
