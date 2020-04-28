defmodule EpasWeb.Router do
  use EpasWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EpasWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/bucket", EpasWeb do
    pipe_through :browser

    get "/", BucketController, :index
    get "/:path", BucketController, :show
    get "/download/:path", BucketController, :download
    post "/create/:path", BucketController, :create
    delete "/delete/:path", BucketController, :delete
    get "/new/:path", BucketController, :new
  end

  scope "/auth", EpasWeb do
    pipe_through :browser

    get "/signout", UserController, :signout
    get "/:provider", UserController, :request
    get "/:provider/callback", UserController, :callback
  end

  scope "/account", EpasWeb do
    pipe_through :browser

    resources "/logs", LogController
    resources "/users", UserController, excepted: [:login, :signout, :request, :callback]
  end

  scope "/", EpasWeb do
    pipe_through :browser

    get "/", UserController, :login
  end

  # Other scopes may use custom stacks.
  # scope "/api", EpasWeb do
  #   pipe_through :api
  # end
end
