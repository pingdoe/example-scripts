-module(erlang_script).
-export([start/0, loop/2]).

start() ->
    Url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18",
    IntervalMinutes = 5,
    
    %% Start required applications for HTTP over SSL
    inets:start(),
    ssl:start(),
    
    io:format("Starting PingDoe heartbeat every ~p minutes...~n", [IntervalMinutes]),
    loop(Url, IntervalMinutes).

loop(Url, IntervalMinutes) ->
    {{Year, Month, Day}, {Hour, Min, Sec}} = calendar:local_time(),
    Timestamp = io_lib:format("~4.10.0B-~2.10.0B-~2.10.0B ~2.10.0B:~2.10.0B:~2.10.0B", 
                              [Year, Month, Day, Hour, Min, Sec]),
                              
    case httpc:request(get, {Url, []}, [], []) of
        {ok, {{_Version, StatusCode, _Reason}, _Headers, _Body}} ->
            io:format("[~s] Ping successful: ~p~n", [Timestamp, StatusCode]);
        {error, Reason} ->
            io:format("[~s] Ping failed: ~p~n", [Timestamp, Reason])
    end,
    
    timer:sleep(IntervalMinutes * 60 * 1000),
    loop(Url, IntervalMinutes).
