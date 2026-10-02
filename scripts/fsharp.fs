open System
open System.Net.Http
open System.Threading

let client = new HttpClient()

// EXAMPLE link replace with own url
let url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
let intervalMinutes = 5

printfn "Starting PingDoe heartbeat every %d minutes..." intervalMinutes

let rec pingLoop () = async {
    let timestamp = DateTime.UtcNow.ToString("o")
    try
        let! response = client.GetAsync(url) |> Async.AwaitTask
        printfn "[%s] Ping successful: %O" timestamp response.StatusCode
    with
    | ex -> printfn "[%s] Ping failed: %s" timestamp ex.Message
    
    do! Async.Sleep(intervalMinutes * 60 * 1000)
    return! pingLoop ()
}

pingLoop () |> Async.RunSynchronously
