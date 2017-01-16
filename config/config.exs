# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :naranjo,
  ecto_repos: [Naranjo.Repo]

# Configures the endpoint
config :naranjo, Naranjo.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "weTy+PHGhOu/4Jud1g5DL7Fb8e0jh9w8je4ucWKlzz5B7292A52Vobju4hy2+hSh",
  render_errors: [view: Naranjo.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Naranjo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# SMTP mailer
config :naranjo, Naranjo.Mailer,
  adapter: Bamboo.SMTPAdapter,
  server: "smtp.gmail.com",
  port: 587,
  username: "horarios.nei@gmail.com",
  password:  "secret_1x2xx",
  tls: :always,
  ssl: false,
  retries: 3

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
