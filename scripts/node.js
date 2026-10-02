const url = "http://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18";
const intervalMinutes = 5;
const intervalMs = intervalMinutes * 60 * 1000;

console.log(`Starting PingDoe heartbeat every ${intervalMinutes} minutes...`);

async function sendPing() {
    try {
        const response = await fetch(url);
        console.log(`[${new Date().toISOString()}] Ping successful: ${response.status}`);
    } catch (error) {
        console.error(`[${new Date().toISOString()}] Ping failed: ${error.message}`);
    }
}

// Send initial ping immediately, then start the loop
sendPing();
setInterval(sendPing, intervalMs);
