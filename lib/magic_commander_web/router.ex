defmodule MagicCommanderWeb.Router do
  use MagicCommanderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MagicCommanderWeb do
    pipe_through :api
  end
end
