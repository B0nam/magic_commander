defmodule MagicCommander.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MagicCommanderWeb.Telemetry,
      MagicCommander.Repo,
      {DNSCluster, query: Application.get_env(:magic_commander, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MagicCommander.PubSub},
      # Start a worker by calling: MagicCommander.Worker.start_link(arg)
      # {MagicCommander.Worker, arg},
      # Start to serve requests, typically the last entry
      MagicCommanderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MagicCommander.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MagicCommanderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
