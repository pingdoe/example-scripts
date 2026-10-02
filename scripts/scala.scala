import java.net.URI
import java.net.http.{HttpClient, HttpRequest, HttpResponse}
import java.time.LocalDateTime
import java.util.concurrent.{Executors, TimeUnit}

object PingDoeHeartbeat extends App {
  // EXAMPLE link replace with own url
  val url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
  val intervalMinutes = 5

  val client = HttpClient.newHttpClient()
  val request = HttpRequest.newBuilder()
    .uri(URI.create(url))
    .GET()
    .build()

  println(s"Starting PingDoe heartbeat every $intervalMinutes minutes...")

  val scheduler = Executors.newScheduledThreadPool(1)
  
  scheduler.scheduleAtFixedRate(new Runnable {
    def run(): Unit = {
      try {
        val response = client.send(request, HttpResponse.BodyHandlers.discarding())
        println(s"[${LocalDateTime.now()}] Ping successful: ${response.statusCode()}")
      } catch {
        case e: Exception => println(s"[${LocalDateTime.now()}] Ping failed: ${e.getMessage}")
      }
    }
  }, 0, intervalMinutes, TimeUnit.MINUTES)
}
