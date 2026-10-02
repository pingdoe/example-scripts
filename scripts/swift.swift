import Foundation

let urlString = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18" // EXAMPLE link replace with own url
let intervalMinutes: Double = 5
let intervalSeconds = intervalMinutes * 60

guard let url = URL(string: urlString) else {
    fatalError("Invalid URL")
}

print("Starting PingDoe heartbeat every \(intervalMinutes) minutes...")

func sendPing() {
    let timestamp = ISO8601DateFormatter().string(from: Date())
    let task = URLSession.shared.dataTask(with: url) { _, response, error in
        if let error = error {
            print("[\(timestamp)] Ping failed: \(error.localizedDescription)")
            return
        }
        if let httpResponse = response as? HTTPURLResponse {
            print("[\(timestamp)] Ping successful: \(httpResponse.statusCode)")
        }
    }
    task.resume()
}

sendPing()

let timer = Timer.scheduledTimer(withTimeInterval: intervalSeconds, repeats: true) { _ in
    sendPing()
}

RunLoop.main.run()
