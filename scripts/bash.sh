#!/usr/bin/env bash

URL="https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18" # EXAMPLE link replace with own url
INTERVAL_MINUTES=5

echo "Starting PingDoe heartbeat every $INTERVAL_MINUTES minutes..."

while true; do
    # -f fails silently on HTTP errors, -s is silent, -S shows errors
    curl -fsS --retry 3 "$URL" > /dev/null
    if [ $? -eq 0 ]; then
        echo "[$(date -u +'%Y-%m-%dT%H:%M:%SZ')] Ping successful"
    else
        echo "[$(date -u +'%Y-%m-%dT%H:%M:%SZ')] Ping failed"
    fi
    sleep "$((INTERVAL_MINUTES * 60))"
done
