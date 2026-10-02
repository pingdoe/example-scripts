using HTTP
using Dates

# EXAMPLE link replace with own url
const url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
const interval_minutes = 5

println("Starting PingDoe heartbeat every $interval_minutes minutes...")

while true
    timestamp = Dates.now()
    try
        response = HTTP.get(url, readtimeout=10)
        println("[$timestamp] Ping successful: $(response.status)")
    catch e
        println("[$timestamp] Ping failed: $e")
    end
    sleep(interval_minutes * 60)
end
