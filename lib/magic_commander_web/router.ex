defmodule MagicCommanderWeb.Router do
  use MagicCommanderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug MagicCommander.GuardianPipeline
  end

  pipeline :usuario_role do
    plug MagicCommander.GuardianPipeline.EnsureRole, "usuario"
  end

  pipeline :moderador_role do
    plug MagicCommander.GuardianPipeline.EnsureRole, "moderador"
  end

  scope "/", MagicCommanderWeb do
    get "/", DefaultController, :index
  end

  scope "/api", MagicCommanderWeb do
    pipe_through :api

    post "/accounts/register", AccountController, :create
    post "/accounts/signin", AccountController, :sign_in
  end

  scope "/api", MagicCommanderWeb do
    pipe_through [:api, :auth, :usuario_role]

    get "/cards", CardController, :index
    get "/cards/:id", CardController, :show
    get "/cards/find/:name", CardController, :find

    get "/decks", DeckController, :index
    get "/decks/:id", DeckController, :show
    post "/decks", DeckController, :create
    get "/decks/:id/export", DeckController, :export
  end

  scope "/api", MagicCommanderWeb do
    pipe_through [:api, :auth, :moderador_role]

    post "/cards", CardController, :create
    post "/decks/:id/import", DeckController, :import
  end
end
