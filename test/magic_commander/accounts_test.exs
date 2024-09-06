defmodule MagicCommander.AccountsTest do
  use MagicCommander.DataCase

  alias MagicCommander.Accounts

  describe "accounts" do
    alias MagicCommander.Accounts.Account

    import MagicCommander.AccountsFixtures

    @invalid_attrs %{email: nil, hash_password: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{email: "teste@teste.com", hash_password: "somehash_password"}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.email == "teste@teste.com"
      assert account.role == "user"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

  end
end
