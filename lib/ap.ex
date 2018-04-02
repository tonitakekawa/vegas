defmodule Ap do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec


    :ets.new(:session, [:named_table, :public, read_concurrency: true])

    children = [
      supervisor(Ap.Repo, []),
      supervisor(Ap.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Ap.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Ap.Endpoint.config_change(changed, removed)
    :ok
  end
end
