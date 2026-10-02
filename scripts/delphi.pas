program PingDoeHeartbeat;

{$APPTYPE CONSOLE}

uses
  System.SysUtils,
  System.Classes,
  System.Net.HttpClient;

const
  URL = 'https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18';
  INTERVAL_MINUTES = 5;

var
  Client: THTTPClient;
  Response: IHTTPResponse;
  Timestamp: string;
begin
  Writeln(Format('Starting PingDoe heartbeat every %d minutes...', [INTERVAL_MINUTES]));
  Client := THTTPClient.Create;
  try
    while True do
    begin
      Timestamp := FormatDateTime('yyyy-mm-dd hh:nn:ss', Now);
      try
        Response := Client.Get(URL);
        Writeln(Format('[%s] Ping successful: %d', [Timestamp, Response.StatusCode]));
      except
        on E: Exception do
          Writeln(Format('[%s] Ping failed: %s', [Timestamp, E.Message]));
      end;
      
      Sleep(INTERVAL_MINUTES * 60 * 1000);
    end;
  finally
    Client.Free;
  end;
end.
