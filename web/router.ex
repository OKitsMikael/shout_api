defmodule ShoutApi.Router do
  use ShoutApi.Web, :router

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

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", ShoutApi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", ShoutApi do
    pipe_through [:api]

    post "/sign_up", AuthController, :sign_up
    post "/login", AuthController, :login

    scope "/" do
      pipe_through :api_auth

      get "/logout", AuthController, :logout

      resources "/users", UserController, only: [:update, :delete] do
        resources "/shouts", ShoutController
      end
    end
  end
end
