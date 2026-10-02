<?php

$url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"; // EXAMPLE link replace with own url
$intervalMinutes = 5;

echo "Starting PingDoe heartbeat every {$intervalMinutes} minutes...\n";

while (true) {
    $timestamp = date('c');
    $context = stream_context_create([
        'http' => [
            'method' => 'GET',
            'timeout' => 10,
            'ignore_errors' => true
        ]
    ]);

    $response = @file_get_contents($url, false, $context);

    if ($response !== false) {
        $statusLine = $http_response_header[0] ?? 'Unknown status';
        echo "[{$timestamp}] Ping sent: {$statusLine}\n";
    } else {
        echo "[{$timestamp}] Ping failed to send.\n";
    }

    sleep($intervalMinutes * 60);
}
