package main

import (
	"fmt"
	"net/http"
	"time"
)

func main() {
	url := "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
	interval := 5 * time.Minute // Can be changed to time.Second etc.

	fmt.Printf("Starting PingDoe heartbeat every %v...\n", interval)
    
    // Trigger immediately on start
	ping(url)

	ticker := time.NewTicker(interval)
	defer ticker.Stop()

	for range ticker.C {
		ping(url)
	}
}

func ping(url string) {
	timestamp := time.Now().Format(time.RFC3339)
	resp, err := http.Get(url)
	if err != nil {
		fmt.Printf("[%s] Ping failed: %v\n", timestamp, err)
		return
	}
	defer resp.Body.Close()
	fmt.Printf("[%s] Ping successful: %s\n", timestamp, resp.Status)
}
