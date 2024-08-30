defmodule MagicCommanderWeb.AccountController do
  use MagicCommanderWeb, :controller

  alias MagicCommander.Accounts
  alias MagicCommander.Accounts.Account
  alias MagicCommander.Guardian

  action_fallback MagicCommanderWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, token, _full_claims} <- Guardian.encode_and_sign(account) do
      conn
      |> put_status(:created)
      |> put_resp_content_type("application/json")
      |> json(%{message: "Account created successfully!", account: account.email, token: token})
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"account" => %{"email" => email, "hash_password" => hash_password}}) do
    case Guardian.authenticate(email, hash_password) do
      {:ok, account, token} ->
        conn
        |> put_status(:ok)
        |> put_resp_content_type("application/json")
        |> json(%{message: "Login successful!", account: account.email, token: token})

      {:error, _reason} ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(:unauthorized, Jason.encode!(%{error: "Invalid credentials"}))
    end
  end
end
