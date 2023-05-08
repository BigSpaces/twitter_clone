defmodule Meta.Discovery do
  @web_services ["http://localhost:4010"]
  @storage_services ["http://localhost:4020"]

  def get_service_url(:web) do
    @web_services
    #Enum.random(@web_services)
  end

  def get_service_url(:storage) do
    @storage_services
    #Enum.random(@storage_services)
  end
end
