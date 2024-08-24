defmodule MagicCommander.Repo do
  use Ecto.Repo,
    otp_app: :magic_commander,
    adapter: Ecto.Adapters.Postgres
end
