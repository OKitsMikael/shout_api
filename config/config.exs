# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shout_api,
  ecto_repos: [ShoutApi.Repo]

# Configures the endpoint
config :shout_api, ShoutApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V2gmLh8H5gL+C1qNzwtEYlKDowv71extwzLRpFn2PAN08+Wrw7getBwetmmqUyi0",
  render_errors: [view: ShoutApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShoutApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
