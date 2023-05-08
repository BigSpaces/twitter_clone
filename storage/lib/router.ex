defmodule Storage.Router do
  use Plug.Router
  import Plug.Conn

  plug(:match)
  plug(:dispatch)

  # Define routes and handlers below
  get "/timeline/:username" do
    username = "Bob" #String.to_integer(conn.params["user_id"])
    tweets = Storage.get_tweets(username)
    # IO.inspect(tweets, label: "tweets")
    # response = Jason.encode!(tweets)
    # send_resp(conn, 200, response)

    timeline = [
      %{
        "id" => 0,
        "user_id" => "Q",
        "username" => "TheQMan",
        "user" => "/users/Q",
        "content" => "I mentor with one hand and design with another",
        "timestamp" => DateTime.to_string(DateTime.utc_now()),
        "likes" => 2500
      },
      %{
        "id" => 0,
        "user_id" => "Q",
        "username" => "TheQMan",
        "user" => "/users/Q",
        "content" => "I cook with one hand and drive with another",
        "timestamp" => DateTime.to_string(DateTime.utc_now()),
        "likes" => 2512
      }
    ]

    response = Jason.encode!(timeline)
    send_resp(conn, 200, response)
  end

  post "/tweets" do
    # Handle the request to store a new tweet
  end

  post "/likes/:tweet_id" do
    # Handle the request to add a like to a tweet
  end

  delete "/likes/:tweet_id/:user_id" do
    # Handle the request to remove a like from a tweet
  end

  post "/follows" do
    # Handle the request to add a follow relationship
  end

  delete "/follows/:follower/:followee" do
    # Handle the request to remove a follow relationship
  end

  get "/stats" do
    # Handle the request to get usage statistics for the storage service
  end
end
