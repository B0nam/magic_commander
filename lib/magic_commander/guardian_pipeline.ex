defmodule MagicCommander.GuardianPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :elixir_api_jwt,
     module: MagicCommander.Guardian,
    error_handler: MagicCommander.GuardianErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
