// In Salesforce, you would schedule this class to run via the UI or Dev Console:
// System.schedule('PingDoe Heartbeat', '0 */5 * * * ?', new PingDoeHeartbeat());

public class PingDoeHeartbeat implements Schedulable {
    
    // Execute method called by the Salesforce scheduler
    public void execute(SchedulableContext ctx) {
        sendPing();
    }

    // Callouts from scheduled jobs must be asynchronous (@future)
    @future(callout=true)
    public static void sendPing() {
        String url = 'https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18';
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod('GET');
        
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            System.debug('[' + System.now() + '] Ping successful: ' + res.getStatusCode());
        } catch(Exception e) {
            System.debug('[' + System.now() + '] Ping failed: ' + e.getMessage());
        }
    }
}
