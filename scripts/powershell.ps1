$url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18" # EXAMPLE link replace with own url
$intervalMinutes = 5

Write-Host "Starting PingDoe heartbeat every $intervalMinutes minutes..."

while ($true) {
    $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    try {
        $response = Invoke-WebRequest -Uri $url -Method Get -UseBasicParsing -TimeoutSec 10
        Write-Host "[$timestamp] Ping successful: $($response.StatusCode)"
    } catch {
        Write-Host "[$timestamp] Ping failed: $_"
    }
    Start-Sleep -Seconds ($intervalMinutes * 60)
}
