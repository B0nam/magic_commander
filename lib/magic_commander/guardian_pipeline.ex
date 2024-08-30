defmodule MagicCommander.GuardianPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :magic_commander,
    module: MagicCommander.Guardian,
    error_handler: MagicCommander.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

  defmodule EnsureRole do
    import Plug.Conn
    alias MagicCommander.Guardian

    def init(role), do: role

    def call(conn, role) do
      case Guardian.Plug.current_claims(conn) do
        %{"role" => user_role} when user_role == role ->
          conn

        _ ->
          conn
          |> send_resp(:forbidden, "Forbidden")
          |> halt()
      end
    end
  end
end
