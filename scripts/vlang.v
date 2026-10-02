import net.http
import time

const url = 'https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18'
const interval_minutes = 5

fn main() {
    println('Starting PingDoe heartbeat every $interval_minutes minutes...')
    
    for {
        now := time.now().format_ss()
        
        resp := http.get(url) or {
            println('[$now] Ping failed: $err')
            time.sleep(interval_minutes * time.minute)
            continue
        }
        
        println('[$now] Ping successful: $resp.status_code')
        time.sleep(interval_minutes * time.minute)
    }
}
