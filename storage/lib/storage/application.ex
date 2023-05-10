defmodule Storage.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Storage.StorageServer,
      {Plug.Cowboy, scheme: :http, plug: Storage.Router, options: [port: 4020]}
      # Starts a worker by calling: Storage.Worker.start_link(arg)
      # {Storage.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one] #, name: Storage.StorageServer]
    started = Supervisor.start_link(children, opts)
    register_with_meta()
    started
  end

  def register_with_meta do
    # Replace with the actual "meta - discovery" microservice URL
    meta_url = "http://localhost:4001/register"
    service_name = "storage"
    # Replace with the actual "web" microservice URL
    service_url = "http://localhost:4020"

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
