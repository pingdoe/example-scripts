import httpclient, os, times, strutils

# EXAMPLE link replace with own url
const url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
const intervalMinutes = 5

echo "Starting PingDoe heartbeat every ", intervalMinutes, " minutes..."

var client = newHttpClient()

while true:
  let timestamp = now().format("yyyy-MM-dd HH:mm:ss")
  try:
    let response = client.request(url, httpMethod = HttpGet)
    echo "[", timestamp, "] Ping successful: ", response.status
  except CatchableError as e:
    echo "[", timestamp, "] Ping failed: ", e.msg
  
  sleep(intervalMinutes * 60 * 1000)
