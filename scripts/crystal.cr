require "http/client"
require "time"

# EXAMPLE link replace with own url
url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
interval_minutes = 5

puts "Starting PingDoe heartbeat every #{interval_minutes} minutes..."

loop do
  timestamp = Time.local
  begin
    response = HTTP::Client.get(url)
    puts "[#{timestamp}] Ping successful: #{response.status_code}"
  rescue ex
    puts "[#{timestamp}] Ping failed: #{ex.message}"
  end
  
  sleep interval_minutes.minutes
end
