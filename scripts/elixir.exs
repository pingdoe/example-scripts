defmodule PingDoeHeartbeat do
  @url ~c"https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18" # EXAMPLE link replace with own url
  @interval_minutes 5

  def start do
    :inets.start()
    :ssl.start()
    IO.puts("Starting PingDoe heartbeat every #{@interval_minutes} minutes...")
    loop()
  end

  defp loop do
    timestamp = DateTime.utc_now() |> DateTime.to_iso8601()

    case :httpc.request(:get, {@url, []}, [], []) do
      {:ok, {{_, status_code, _}, _headers, _body}} ->
        IO.puts("[#{timestamp}] Ping successful: #{status_code}")
      {:error, reason} ->
        IO.puts("[#{timestamp}] Ping failed: #{inspect(reason)}")
    end

    :timer.sleep(@interval_minutes * 60 * 1000)
    loop()
  end
end

PingDoeHeartbeat.start()
