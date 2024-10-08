# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :magic_commander,
  ecto_repos: [MagicCommander.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :magic_commander, MagicCommanderWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: MagicCommanderWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: MagicCommander.PubSub,
  live_view: [signing_salt: "UeJRZnJk"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :magic_commander, MagicCommander.Guardian,
    issuer: "magic_commander",
    secret_key: "FL9EGGCSjWUh4sfoISZPxWHVcsjOY8I9c+OjGydAfc0Sais4CB0USlI43OPrRW0N"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
