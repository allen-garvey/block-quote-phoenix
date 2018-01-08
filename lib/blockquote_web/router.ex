defmodule BlockquoteWeb.Router do
  use BlockquoteWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlockquoteWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end
  
  scope "/admin", BlockquoteWeb do
    pipe_through :browser # Use the default browser stack
    
    get "/", AdminController, :index
    
    resources "/authors", AuthorController
    resources "/categories", CategoryController
    resources "/source-types", SourceTypeController
    resources "/parent-sources", ParentSourceController
    resources "/sources", SourceController
    resources "/quotes", QuoteController
    resources "/daily-quotes", DailyQuoteController
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlockquoteWeb do
  #   pipe_through :api
  # end
end
