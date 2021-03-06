# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bank_api,
  namespace: BankAPI,
  ecto_repos: [BankAPI.Repo]

# Configures the endpoint
config :bank_api, BankAPIWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1SWzse8ni7jj8yLyTRQvi4nxmRufk/Xd2lRvx5VYDXwbXaHT4CFmxKXNKkKK5zIs",
  render_errors: [view: BankAPIWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: BankAPI.PubSub,
  live_view: [signing_salt: "UvBz4M+q"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: BankAPI.Repo

config :commanded, default_consistency: :strong

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
