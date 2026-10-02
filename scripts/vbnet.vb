Imports System.Net.Http
Imports System.Threading.Tasks

Module VbNetPing
    Private ReadOnly client As New HttpClient()

    Sub Main()
        Dim url As String = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
        Dim intervalMinutes As Integer = 5

        Console.WriteLine($"Starting PingDoe heartbeat every {intervalMinutes} minutes...")
        
        ' Run async task synchronously for a console app loop
        RunHeartbeat(url, intervalMinutes).GetAwaiter().GetResult()
    End Sub

    Async Function RunHeartbeat(url As String, intervalMinutes As Integer) As Task
        While True
            Dim timestamp As String = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")
            Try
                Dim response As HttpResponseMessage = Await client.GetAsync(url)
                Console.WriteLine($"[{timestamp}] Ping successful: {CInt(response.StatusCode)}")
            Catch ex As Exception
                Console.WriteLine($"[{timestamp}] Ping failed: {ex.Message}")
            End Try

            Await Task.Delay(intervalMinutes * 60 * 1000)
        End While
    End Function
End Module
