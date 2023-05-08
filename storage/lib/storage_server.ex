defmodule Storage.StorageServer do
  use GenServer

  # Client API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_tweets(user_id) do
    GenServer.call(__MODULE__, {:get_tweets, user_id})
  end

  # Server callbacks

  def init(:ok) do
    :ets.new(:tweets, [:set, :protected, :named_table])
    seed_data()
    {:ok, %{}}
  end

  def handle_call({:get_tweets, username}, _from, _state) do
    tweets = :ets.match_object(:tweets, {:_, :_, username, :_, :_})
    {:reply, tweets, _state}
  end

  # Helper function to seed data

  defp seed_data() do
    :ets.insert(:tweets, [
      {1, 1, "Alice", "Hello, world!", ~U[2023-04-30 12:00:00Z], 0},
      {2, 2, "Bob", "Hello, Twitter clone!", ~U[2023-04-30 12:05:00Z], 0}
    ])
  end

  def running? do
    case Process.whereis(__MODULE__) do
      nil -> false
      _pid -> true
    end
  end

end
