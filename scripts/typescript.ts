const url: string = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18";
const intervalMinutes: number = 5;
const intervalMs: number = intervalMinutes * 60 * 1000;

console.log(`Starting PingDoe heartbeat every ${intervalMinutes} minutes...`);

async function sendPing(): Promise<void> {
    const timestamp = new Date().toISOString();
    try {
        const response = await fetch(url);
        console.log(`[${timestamp}] Ping successful: ${response.status}`);
    } catch (error) {
        // Narrowing the error type
        const message = error instanceof Error ? error.message : String(error);
        console.error(`[${timestamp}] Ping failed: ${message}`);
    }
}

sendPing();
setInterval(sendPing, intervalMs);
