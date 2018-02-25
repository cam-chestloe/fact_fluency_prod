use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fact_fluency, FactFluencyWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :fact_fluency, FactFluency.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "fact_fluency_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure Guardian
config :fact_fluency, FactFluency.Guardian,
        issuer: "fact_fluency",
        secret_key: "ARe6FkwpF7BaaObwfOScXpEKitIJ+vWvC0/90hq97TzsetESzcquRsABsUPVT4JY"    # Temp

# Configure Guardian_DB
config :guardian, Guardian.DB,
        repo: FactFluency.Repo,
        schema_name: "guardian_tokens",
        sweep_interval: 60