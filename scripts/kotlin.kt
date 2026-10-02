import java.net.URI
import java.net.http.HttpClient
import java.net.http.HttpRequest
import java.net.http.HttpResponse
import java.time.Instant
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit

fun main() {
    val url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18" // EXAMPLE link replace with own url
    val intervalMinutes = 5L

    val client = HttpClient.newHttpClient()
    val request = HttpRequest.newBuilder()
        .uri(URI.create(url))
        .GET()
        .build()

    println("Starting PingDoe heartbeat every $intervalMinutes minutes...")

    val scheduler = Executors.newScheduledThreadPool(1)
    scheduler.scheduleAtFixedRate({
        val timestamp = Instant.now()
        try {
            val response = client.send(request, HttpResponse.BodyHandlers.discarding())
            println("[$timestamp] Ping successful: ${response.statusCode()}")
        } catch (e: Exception) {
            println("[$timestamp] Ping failed: ${e.message}")
        }
    }, 0, intervalMinutes, TimeUnit.MINUTES)
}
