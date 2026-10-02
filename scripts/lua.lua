local http = require("socket.http")
local os = require("os")

-- EXAMPLE link replace with own url
local url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
local interval_minutes = 5

print("Starting PingDoe heartbeat every " .. interval_minutes .. " minutes...")

while true do
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    -- luasocket request
    local body, code, headers, status = http.request(url)
    
    if code == 200 then
        print("[" .. timestamp .. "] Ping successful: " .. tostring(code))
    else
        print("[" .. timestamp .. "] Ping failed. Status: " .. tostring(status))
    end
    
    -- Basic OS sleep wrapper
    os.execute("sleep " .. tonumber(interval_minutes * 60))
end
