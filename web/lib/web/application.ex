defmodule Web.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Web.Router, options: [port: 4010]}
      # Starts a worker by calling: Web.Worker.start_link(arg)
      # {Web.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    # , name: Web.Supervisor]
    opts = [strategy: :one_for_one]
    started = Supervisor.start_link(children, opts)
    register_with_meta()
    started
  end

  def register_with_meta do
    # Replace with the actual "meta - discovery" microservice URL
    meta_url = "http://localhost:4001/register"
    service_name = "web"
    # Replace with the actual "web" microservice URL
    service_url = "http://localhost:4010"

    payload =
      %{
        "service" => service_name,
        "url" => service_url
      }
      |> Jason.encode!()

    headers = [{"Content-Type", "application/json"}]
    HTTPoison.post(meta_url, payload, headers)
  end
end
