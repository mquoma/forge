defmodule Forge.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Forge.Repo,
      # Start the Telemetry supervisor
      ForgeWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Forge.PubSub},
      # Start the Endpoint (http/https)
      ForgeWeb.Endpoint
      # Start a worker by calling: Forge.Worker.start_link(arg)
      # {Forge.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Forge.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ForgeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
