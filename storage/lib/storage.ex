defmodule Storage do
  @moduledoc """
  Documentation for `Storage`.
  """

  def get_tweets(username) do
    Storage.StorageServer.get_tweets(username)
  end
end
