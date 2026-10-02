import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.LocalDateTime;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class PingDoeHeartbeat {
    public static void main(String[] args) {
        String url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"; // example, replace with own url
        long intervalMinutes = 5;

        HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .GET()
                .build();

        ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(1);
        System.out.println("Starting PingDoe heartbeat every " + intervalMinutes + " minutes...");

        scheduler.scheduleAtFixedRate(() -> {
            try {
                HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.discarding());
                System.out.println("[" + LocalDateTime.now() + "] Ping successful: " + response.statusCode());
            } catch (Exception e) {
                System.out.println("[" + LocalDateTime.now() + "] Ping failed: " + e.getMessage());
            }
        }, 0, intervalMinutes, TimeUnit.MINUTES);
    }
}
