import gleam/io
import gleam/http/request
import gleam/hackney
import gleam/erlang/process
import gleam/int

pub fn main() {
  let url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
  let interval_minutes = 5
  
  io.println("Starting PingDoe heartbeat every " <> int.to_string(interval_minutes) <> " minutes...")

  let assert Ok(req) = request.to(url)

  let loop = fn() {
    case hackney.send(req) {
      Ok(resp) -> io.println("Ping successful: " <> int.to_string(resp.status))
      Error(_) -> io.println("Ping failed to send")
    }
    process.sleep(interval_minutes * 60 * 1000)
  }
  
  // Start the recursive loop
  run_loop(loop)
}

fn run_loop(loop_fn: fn() -> Nil) {
  loop_fn()
  run_loop(loop_fn)
}
