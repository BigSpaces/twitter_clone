defmodule Meta.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Meta.Router, options: [port: 4001]}
      # Starts a worker by calling: Meta.Worker.start_link(arg)
      # {Meta.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Meta.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
