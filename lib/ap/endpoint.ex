defmodule Ap.Endpoint do
  use Phoenix.Endpoint, otp_app: :ap

  socket "/socket", Ap.UserSocket

  plug Plug.Static,
    at: "/", from: :ap, gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

#  plug Plug.Session,
#    store: :cookie,
#    key: "_hello_key",
#    signing_salt: "Jk7pxAMf"

  plug Plug.Session,
    store: PlugSessionRedis.Store,
    key: "_my_app_key",           #
    table: :redis_sessions,       # Can be anything you want, should be same as `:name` config above
    signing_salt: "123456",       #
    encryption_salt: "654321",    #
    ttl: 360

  plug Ap.Router
end
