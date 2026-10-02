import time
import urllib.request
from urllib.error import URLError, HTTPError
from datetime import datetime

URL = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
INTERVAL_MINUTES = 5

print(f"Starting PingDoe heartbeat every {INTERVAL_MINUTES} minutes...")

while True:
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    try:
        response = urllib.request.urlopen(URL)
        print(f"[{timestamp}] Ping successful: {response.getcode()}")
    except HTTPError as e:
        print(f"[{timestamp}] Ping failed with HTTP status: {e.code}")
    except URLError as e:
        print(f"[{timestamp}] Ping failed: {e.reason}")
        
    time.sleep(INTERVAL_MINUTES * 60)
