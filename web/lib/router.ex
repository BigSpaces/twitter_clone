defmodule Web.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)
  @meta_url :"http://localhost:4001/"
  # Define routes and handlers below

  get "/timeline/:username" do
    # user_id = String.to_integer(conn.params["user"])
    timeline = fetch_timeline(username)

    html = render_timeline(timeline)

    send_resp(conn, 200, html)
  end

  defp fetch_service_url(service) do
    storage_endpoint = "#{@meta_url}services/#{service}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(storage_endpoint)
    Jason.decode!(body)["url"] |>  List.to_string()
  end

  defp fetch_timeline(username) do
    storage_url = fetch_service_url("storage")
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(storage_url <> "/timeline/username")
    Jason.decode!(body) 
  end

  defp render_timeline(timeline) do
    tweets_html =
      Enum.map_join(timeline, "", fn tweet ->
        """
        <div class="tweet">
          <div class="tweet-header">
            <span class="username">#{tweet["username"]}</span>
            <span class="timestamp">#{tweet["timestamp"]}</span>
          </div>
          <div class="tweet-content">
            #{tweet["content"]}
          </div>
          <div class="tweet-footer">
            <span class="likes">#{tweet["likes"]} likes</span>
          </div>
        </div>
        """
      end)

    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Timeline</title>
      <style>
        .tweet {border: 1px solid #ccc; padding: 1rem; margin: 1rem 0;}
        .tweet-header {display: flex; justify-content: space-between; margin-bottom: 1rem;}
        .username {font-weight: bold;}
        .timestamp {color: #999; font-size: 0.8rem;}
        .tweet-content {margin-bottom: 1rem;}
        .tweet-footer {text-align: right;}
      </style>
    </head>
    <body>
      <h1>Timeline</h1>
      <div class="tweets">
        #{tweets_html}
      </div>
    </body>
    </html>
    """
  end

  post "/tweet" do
    # Handle the request to post a tweet
  end

  post "/like/:tweet_id" do
    # Handle the request to like a tweet
  end

  post "/unlike/:tweet_id" do
    # Handle the request to unlike a tweet
  end

  post "/follow/:user_id" do
    # Handle the request to follow a user
  end

  post "/unfollow/:user_id" do
    # Handle the request to unfollow a user
  end

  get "/stats" do
    # Handle the request to get usage statistics for the web service
  end
end
