// EXAMPLE link replace with own url
def url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
def intervalMinutes = 5

println "Starting PingDoe heartbeat every ${intervalMinutes} minutes..."

while (true) {
    try {
        def connection = new URL(url).openConnection()
        connection.setRequestMethod("GET")
        def responseCode = connection.getResponseCode()
        println "[${new Date()}] Ping successful: ${responseCode}"
    } catch (Exception e) {
        println "[${new Date()}] Ping failed: ${e.message}"
    }
    sleep(intervalMinutes * 60 * 1000)
}
