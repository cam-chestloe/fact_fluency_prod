# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fact_fluency,
  ecto_repos: [FactFluency.Repo]

# Configures the endpoint
config :fact_fluency, FactFluencyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bSGMS+nZWD5juRPYRXQzCgQ9xWmJL9HJ6hhWi13AwXJQrS6QxKdfrKcNRGTJxVsw",
  render_errors: [view: FactFluencyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FactFluency.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :template_engines,
  drab: Drab.Live.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
