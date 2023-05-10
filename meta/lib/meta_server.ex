defmodule Meta.MetaServer do
  use GenServer
  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def register_service(service_name, url) do
    GenServer.call(__MODULE__, {:register_service, service_name, url})
  end

  def get_service_url(service_name) do
    GenServer.call(__MODULE__, {:get_service_url, service_name})
  end

  # Server Callbacks

  @impl true
  def init(initial_state) do
    IO.inspect(initial_state, label: "INITIAL STATE")
    {:ok, initial_state}
  end

  @impl true
  def handle_call({:register_service, service_name, url}, _from, state) do
    new_state = Map.put(state, service_name, url)
    IO.inspect(new_state, label: "SERVICE REGISTERED")
    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:get_service_url, service_name}, _from, state) do
    url = Map.get(state, service_name)
    {:reply, url, state}
  end

end
