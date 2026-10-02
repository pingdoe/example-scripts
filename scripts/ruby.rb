require 'net/http'
require 'uri'
require 'time'

url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18" # EXAMPLE link replace with own url
interval_minutes = 5

puts "Starting PingDoe heartbeat every #{interval_minutes} minutes..."

loop do
  timestamp = Time.now.utc.iso8601
  begin
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    puts "[#{timestamp}] Ping successful: #{response.code}"
  rescue StandardError => e
    puts "[#{timestamp}] Ping failed: #{e.message}"
  end

  sleep(interval_minutes * 60)
end
