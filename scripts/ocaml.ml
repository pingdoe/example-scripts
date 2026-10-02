(* Requires cohttp-lwt-unix package: opam install cohttp-lwt-unix *)
open Lwt
open Cohttp
open Cohttp_lwt_unix

let url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
let interval_minutes = 5.0

let rec ping_loop () =
  let timestamp = Unix.gettimeofday () |> Unix.localtime in
  let time_str = Printf.sprintf "%04d-%02d-%02d %02d:%02d:%02d"
    (timestamp.tm_year + 1900) (timestamp.tm_mon + 1) timestamp.tm_mday
    timestamp.tm_hour timestamp.tm_min timestamp.tm_sec in
  
  Lwt.catch
    (fun () ->
      Client.get (Uri.of_string url) >>= fun (resp, _body) ->
      let code = resp |> Response.status |> Code.code_of_status in
      Printf.printf "[%s] Ping successful: %d\n%!" time_str code;
      Lwt.return_unit)
    (fun exn ->
      Printf.printf "[%s] Ping failed: %s\n%!" time_str (Printexc.to_string exn);
      Lwt.return_unit)
  >>= fun () ->
  Lwt_unix.sleep (interval_minutes *. 60.0) >>= fun () ->
  ping_loop ()

let () =
  Printf.printf "Starting PingDoe heartbeat every %d minutes...\n%!" (int_of_float interval_minutes);
  Lwt_main.run (ping_loop ())
