using System;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;

class Program
{
    private static readonly HttpClient client = new HttpClient();

    static async Task Main(string[] args)
    {
        string url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"; // EXAMPLE link replace with own url
        int intervalMinutes = 5;

        Console.WriteLine($"Starting PingDoe heartbeat every {intervalMinutes} minutes...");

        using var timer = new PeriodicTimer(TimeSpan.FromMinutes(intervalMinutes));

        await SendPingAsync(url);

        while (await timer.WaitForNextTickAsync())
        {
            await SendPingAsync(url);
        }
    }

    static async Task SendPingAsync(string url)
    {
        string timestamp = DateTime.UtcNow.ToString("o");
        try
        {
            HttpResponseMessage response = await client.GetAsync(url);
            Console.WriteLine($"[{timestamp}] Ping successful: {response.StatusCode}");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[{timestamp}] Ping failed: {ex.Message}");
        }
    }
}
