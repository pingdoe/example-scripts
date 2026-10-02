url = 'https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18';
intervalMinutes = 5;

fprintf('Starting PingDoe heartbeat every %d minutes...\n', intervalMinutes);

while true
    timestamp = datestr(now, 'yyyy-mm-dd HH:MM:SS');
    
    try
        options = weboptions('Timeout', 10);
        % webread will throw an exception if the response status is not 2xx
        response = webread(url, options);
        fprintf('[%s] Ping successful.\n', timestamp);
    catch ME
        % Catches both network errors and HTTP error codes
        fprintf('[%s] Ping failed: %s\n', timestamp, ME.message);
    end
    
    pause(intervalMinutes * 60);
end
