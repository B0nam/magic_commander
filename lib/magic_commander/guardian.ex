defmodule MagicCommander.Guardian do
  use Guardian, otp_app: :magic_commander

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    case MagicCommander.Accounts.get_account!(id) do
      nil -> {:error, :reason_for_error}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def authenticate(email, password) do
    case MagicCommander.Accounts.get_account_by_email(email) do
      nil ->
        {:error, :unauthorized}

      resource ->
        case validate_password(password, resource.hash_password) do
          true -> create_token(resource)
          false -> {:error, :reason_for_error}
        end
    end
  end

  def validate_password(password, hash_password) do
    Bcrypt.verify_pass(password, hash_password)
  end

  defp create_token(account) do
    {:ok, token, _full_claims} =
      encode_and_sign(account)

    {:ok, account, token}
 end
end
