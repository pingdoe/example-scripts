use std::time::Duration;
use tokio::time;

#[tokio::main]
async fn main() {
    let url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"; // // EXAMPLE link replace with own url
    let interval_minutes = 5;
    
    let mut interval = time::interval(Duration::from_secs(interval_minutes * 60));
    
    println!("Starting PingDoe heartbeat every {} minutes...", interval_minutes);

    loop {
        // Wait for the tick (fires immediately the first time)
        interval.tick().await;

        match reqwest::get(url).await {
            Ok(response) => {
                println!("Ping successful: {}", response.status());
            }
            Err(e) => {
                eprintln!("Ping failed: {}", e);
            }
        }
    }
}
