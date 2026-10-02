extends Node

var url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
var interval_minutes = 5
var http_request : HTTPRequest

func _ready():
    print("Starting PingDoe heartbeat every %d minutes..." % interval_minutes)
    
    # Setup HTTP client node
    http_request = HTTPRequest.new()
    add_child(http_request)
    http_request.request_completed.connect(self._on_request_completed)
    
    # Setup looping timer node
    var timer = Timer.new()
    timer.wait_time = interval_minutes * 60
    timer.autostart = true
    timer.timeout.connect(self._send_ping)
    add_child(timer)
    
    _send_ping() # Send first ping immediately

func _send_ping():
    var error = http_request.request(url)
    if error != OK:
        print("[%s] Ping request failed to instantiate. Error code: %d" % [Time.get_datetime_string_from_system(), error])

func _on_request_completed(result, response_code, headers, body):
    var time = Time.get_datetime_string_from_system()
    if result == HTTPRequest.RESULT_SUCCESS:
        print("[%s] Ping successful: %d" % [time, response_code])
    else:
        print("[%s] Ping failed. Node Result code: %d" % [time, result])
