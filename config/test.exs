import Config

config :magic_commander, MagicCommander.Repo,
  username: "magiccommander",
  password: "magicpasswd",
  hostname: "localhost",
  database: "magic_commander_dev",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :magic_commander, MagicCommanderWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "qspg0jglGqfrYAu44UKUR7EpgE8mogCzEZutJuo36a2m4jfvVL9C2t9aBDvs3rTh",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
