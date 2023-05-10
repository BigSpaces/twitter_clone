defmodule Meta.Router do
  use Plug.Router
  import Plug.Conn.Status, only: [code: 1]


  plug(:match)
  plug(:dispatch)

  # Define routes and handlers below
  get "/timeline/:user" do
    conn
    |> Plug.Conn.put_resp_header(
      "location",
       to_string(
        Meta.Discovery.get_service_url(:web) +
        "/timeline/#{conn.params["type"]}"
        )
       )
    |> Plug.Conn.send_resp(302, "")
    |> Plug.Conn.halt()
  end

  @doc """
  This function should return (JSON) a list of the registered
  services of the requested type.
  """
  get "/services/:type" do
    type = conn.params["type"]

    service_url =
      case type do
        "web" -> Meta.Discovery.get_service_url(:web)
        "storage" -> Meta.Discovery.get_service_url(:storage)
        _ -> nil
      end

    case service_url do
      nil ->
        send_resp(conn, code(:not_found), "Service type not found")


    url ->
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{url: service_url}))
      # url ->
      #   conn
      #   |> Plug.Conn.put_resp_header("location", to_string(url))
      #   |> Plug.Conn.send_resp(302, "")
      #   |> Plug.Conn.halt()
      #   conn

        # |> redirect(to: to_string(url))
        # |> halt()
    end
  end


  get "/stats" do
    # Handle the request to get usage statistics for the meta service
  end

  post "/register" do #has to be a post
    register_service(conn)
  end

  defp register_service(conn) do
    {:ok, body, _conn} = read_body(conn)
    case Jason.decode(body) do
      {:ok, %{"service" => service_name, "url" => service_url}} ->
        Meta.MetaServer.register_service(service_name, service_url)
        send_resp(conn, 201, "Service registered")
        {:error, _reason} ->
          send_resp(conn, 400, "Invalid JSON format")
        end
      end

      match _ do
        send_resp(conn, 404, "Page not found")
      end
end
