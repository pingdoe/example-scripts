package main

import "core:fmt"
import "core:time"
import "core:os"
import "core:strings"

// Note: Odin's standard library does not have a high-level HTTP client yet. 
// For a simple standalone script, calling curl via the OS is the most lightweight method 
// without pulling in 3rd party HTTP packages.

main :: proc() {
    url := "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
    interval_minutes :: 5
    
    fmt.printf("Starting PingDoe heartbeat every %d minutes...\n", interval_minutes)

    for {
        // Build the curl command to fetch only the HTTP status code
        cmd := fmt.tprintf("curl -s -o /dev/null -w \"%%{http_code}\" %s", url)
        
        exit_code, stdout, stderr := os.command_line_execute(cmd)
        
        now := time.now()
        
        if exit_code == 0 {
            status_code := strings.trim_space(string(stdout))
            fmt.printf("[%v] Ping successful: %s\n", now, status_code)
        } else {
            fmt.printf("[%v] Ping failed. Curl exit code: %d\n", now, exit_code)
        }
        
        time.sleep(time.Minute * interval_minutes)
    }
}
