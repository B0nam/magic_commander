defmodule MagicCommanderWeb.Router do
  use MagicCommanderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug MagicCommander.GuardianPipeline
  end

  scope "/", MagicCommanderWeb do
    get "/", DefaultController, :index
  end

  scope "/api", MagicCommanderWeb do
    pipe_through :api

    post "/accounts/register", AccountController, :create
    post "/accounts/signin", AccountController, :sign_in

    get "/cards", CardController, :index
    get "/cards/:id", CardController, :show
    post "/cards", CardController, :create
    get "/cards/find/:name", CardController, :find
  end

  scope "/api", MagicCommanderWeb do
    pipe_through [:api, :auth]

    get "/decks", DeckController, :index
    get "/decks/:id", DeckController, :show
    post "/decks", DeckController, :create
    delete "/decks", DeckController, :delete

    post "/decks/:id/populate", DeckController, :populate
    post "/decks/:id/import", DeckController, :import
    get "/decks/:id/export", DeckController, :export
  end
end
