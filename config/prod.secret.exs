use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.

# You can generate a new secret by running:
#
#     mix phoenix.gen.secret
config :naranjo, Naranjo.Endpoint,
  secret_key_base: "b4NhWcX9lRfWfR8BVG3BwdeWNHhPKpvFgz//4ZNKsO2SEzVlNV3WZw7VBRwcyLU7"

# Configure your database
config :naranjo, Naranjo.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "naranjo_prod",
  hostname: "postgresql",
  pool_size: 10 # The amount of database connections in the pool
