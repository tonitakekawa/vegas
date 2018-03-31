

use Mix.Config

config :ap,
  ecto_repos: [Ap.Repo]

config :ap, Ap.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ZvOpylI4txBgOK/VT/xP5iUwKQb88Vo5dyNPn9i9okgys3pTsIIAmOYGIvuStVvG",
  render_errors: [view: Ap.ErrorView, accepts: ~w(html json)],
  pubsub:
  [
    name: Ap.PubSub,
    adapter: Phoenix.PubSub.PG2
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :exredis,
  host:      "192.168.3.5",
  port:      6379,
  password:  "",
  db:        0,
  reconnect: :no_reconnect,
  max_queue: :infinity

config :plug_session_redis, :config,
  name:  :redis_sessions,
  pool:  [size: 2, max_overflow: 5],
  redis: [host: '192.168.3.5', port: 6379]



import_config "#{Mix.env}.exs"
