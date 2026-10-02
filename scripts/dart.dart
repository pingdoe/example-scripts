import 'dart:async';
import 'dart:io';

void main() {
  final String url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"; // EXAMPLE link replace with own url
  final int intervalMinutes = 5;
  final httpClient = HttpClient();

  print("Starting PingDoe heartbeat every $intervalMinutes minutes...");

  Future<void> sendPing() async {
    final timestamp = DateTime.now().toUtc().toIso8601String();
    try {
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();
      print("[$timestamp] Ping successful: ${response.statusCode}");
    } catch (e) {
      print("[$timestamp] Ping failed: $e");
    }
  }

  sendPing();

  Timer.periodic(Duration(minutes: intervalMinutes), (timer) {
    sendPing();
  });
}
