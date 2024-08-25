defmodule MagicCommanderWeb.Router do
  use MagicCommanderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MagicCommanderWeb do
    get "/", DefaultController, :index
  end

  scope "/api", MagicCommanderWeb do
    pipe_through :api

    get "/cards", CardController, :index
    get "/cards/:id", CardController, :show
    post "/cards", CardController, :create
    get "/cards/find/:name", CardController, :find

    get "/decks", DeckController, :index
    get "/decks/:id", DeckController, :show
    post "/decks", DeckController, :create
    delete "/decks", DeckController, :delete

    post "/decks/:id/populate", DeckCardController, :populate
    post "/decks/:id/import", DeckCardController, :import
    get "/decks/:id/export", DeckCardController, :expor

  end
end
