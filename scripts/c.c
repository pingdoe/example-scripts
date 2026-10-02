#include <stdio.h>
#include <unistd.h>
#include <curl/curl.h>

int main(void) {
    // EXAMPLE link replace with own url
    const char *url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18";
    int interval_minutes = 5;

    printf("Starting PingDoe heartbeat every %d minutes...\n", interval_minutes);

    curl_global_init(CURL_GLOBAL_DEFAULT);
    CURL *curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_NOBODY, 1L); // Just need the heartbeat, no body

        while(1) {
            CURLcode res = curl_easy_perform(curl);
            
            if(res != CURLE_OK) {
                fprintf(stderr, "Ping failed: %s\n", curl_easy_strerror(res));
            } else {
                long response_code;
                curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &response_code);
                printf("Ping successful, Status: %ld\n", response_code);
            }
            
            sleep(interval_minutes * 60);
        }
        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
    
    return 0;
}
