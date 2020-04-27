# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :epas,
  ecto_repos: [Epas.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :epas, EpasWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "usxjxsuaiWmVwI+qbVx60UzMffTJg7xsPau0nFs3WKnyFonLsm6jRytaB5I2tT/v",
  render_errors: [view: EpasWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Epas.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "XY/0dwxL"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
