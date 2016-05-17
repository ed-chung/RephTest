defmodule Reph do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Reph.Endpoint, []),
      # Start the Ecto repository
      supervisor(Reph.Repo, []),
      supervisor(Reph.ReactIO, []),
      # Here you could define other workers and supervisors as children
      worker(Reph.Connections, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Reph.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Reph.Endpoint.config_change(changed, removed)
    :ok
  end

  # Just a shortcut to Phoenix.PubSub.broadcast(Reph.PubSub, channel, message)
  def broadcast(channel, message) do
    Phoenix.PubSub.broadcast(Reph.PubSub, channel, message)
  end

  # Just a shortcut to Phoenix.PubSub.subscribe(Reph.PubSub, pid, channel)
  def subscribe(pid, channel) do
    Phoenix.PubSub.subscribe(Reph.PubSub, pid, channel)
  end
end
