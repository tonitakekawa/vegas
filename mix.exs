defmodule Ap.Mixfile do
  use Mix.Project

  def project do
  [
    app:             :ap,
    version:         "0.0.1",
    elixir:          "~> 1.2",
    elixirc_paths:   elixirc_paths(Mix.env),
    compilers:       [:phoenix, :gettext] ++ Mix.compilers,
    build_embedded:  Mix.env == :prod,
    start_permanent: Mix.env == :prod,
    aliases:         aliases(),
    deps:            deps()
  ]
  end

  def application do
  [
    mod: {Ap, []},
    applications: [
      :phoenix,
      :phoenix_pubsub,
      :phoenix_html,
      :cowboy,
      :logger,
      :gettext,
      :phoenix_ecto,
      :postgrex,
      :plug_session_redis
    ]
  ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  defp deps do
  [
     {:phoenix,             "~> 1.2.5"           },
     {:phoenix_pubsub,      "~> 1.0"             },
     {:phoenix_ecto,        "~> 3.0"             },
     {:postgrex,            ">= 0.0.0"           },
     {:phoenix_html,        "~> 2.6"             },
     {:phoenix_live_reload, "~> 1.0", only: :dev },
     {:gettext,             "~> 0.11"            },
     {:cowboy,              "~> 1.0"             },
     {:exredis,             ">= 0.2.2"           },
     {:plug_session_redis,  "~> 0.1"             },
     {:cors_plug,           "~> 1.2"             },
  ]
  end

  defp aliases do
  [
    "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
    "ecto.reset": ["ecto.drop", "ecto.setup"],
    "test":       ["ecto.create --quiet", "ecto.migrate", "test"]
  ]
  end
end
