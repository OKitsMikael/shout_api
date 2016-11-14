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

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "ShoutApi",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "7sNzMB2MRIEcU1Qa5RTcdHtrC3iDFAY41McBUrpDJ5r+tjYT9Vi2OyvbobJKh39B",
  serializer: ShoutApi.GuardianSerializer

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
