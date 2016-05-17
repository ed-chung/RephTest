# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :reph, Reph.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "sqcrWdl19phpIoFq4Bw3p7XAQur08u4mx8bwmkR14QTB181BZu++wcKYXCQdIaaj",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Reph.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :porcelain,
  driver: Porcelain.Driver.Basic

config :guardian, Guardian,
  issuer: "reph2",
  ttl: {30, :days},
  secret_key: "MrYcDkNUQpY1pCWxiL1K3BGKzXVO1RkKZLTlIhwlSYU0AFZ6jyMHbgmiG8o2leqg",
  serializer: Reph.Guardian.Serializer,
  hooks: GuardianDb

config :guardian_db, GuardianDb,
  repo: Reph.Repo,
  schema_name: "tokens"