library(httr)

# EXAMPLE link replace with own url
url <- "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
interval_minutes <- 5

cat(sprintf("Starting PingDoe heartbeat every %d minutes...\n", interval_minutes))

repeat {
  timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  
  tryCatch({
    response <- GET(url, timeout(10))
    cat(sprintf("[%s] Ping successful: %s\n", timestamp, status_code(response)))
  }, error = function(e) {
    cat(sprintf("[%s] Ping failed: %s\n", timestamp, e$message))
  })
  
  Sys.sleep(interval_minutes * 60)
}
