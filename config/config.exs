# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :nutrition,
  ecto_repos: [Nutrition.Repo]

# Configures the endpoint
config :nutrition, Nutrition.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WK1ut8odu/QWgdpV4MAmxtZRfM8cVMf/fzyX3I8GdN0PfgGjRTgfmSAkTBUV5p/8",
  render_errors: [view: Nutrition.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nutrition.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
