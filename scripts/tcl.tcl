package require http
package require tls ;# Required for HTTPS support

# Register TLS for HTTPS requests
http::register https 443 [list ::tls::socket -autoservername true]

set url "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
set intervalMinutes 5
set intervalMs [expr {$intervalMinutes * 60 * 1000}]

puts "Starting PingDoe heartbeat every $intervalMinutes minutes..."

proc sendPing {} {
    global url intervalMs
    
    set systemTime [clock seconds]
    set timestamp [clock format $systemTime -format "%Y-%m-%d %H:%M:%S"]
    
    if {[catch {
        set token [http::geturl $url -timeout 10000]
        set status [http::ncode $token]
        puts "\[$timestamp\] Ping successful: $status"
        http::cleanup $token
    } errMsg]} {
        puts "\[$timestamp\] Ping failed: $errMsg"
    }
    
    after $intervalMs sendPing
}

# Send initial ping and start the event loop
sendPing
vwait forever
