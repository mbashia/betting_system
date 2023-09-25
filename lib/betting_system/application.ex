defmodule BettingSystem.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BettingSystem.Repo,
      # Start the Telemetry supervisor
      BettingSystemWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BettingSystem.PubSub},
      # Start the Endpoint (http/https)
      BettingSystemWeb.Endpoint,
      {Finch, name: Swoosh.Finch}

      # Start a worker by calling: BettingSystem.Worker.start_link(arg)
      # {BettingSystem.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BettingSystem.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BettingSystemWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
