#include <iostream>
#include <thread>
#include <chrono>
#include <curl/curl.h>

int main() {
    const char* url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"; // // EXAMPLE link replace with own url
    int interval_minutes = 5;

    std::cout << "Starting PingDoe heartbeat every " << interval_minutes << " minutes...\n";

    curl_global_init(CURL_GLOBAL_DEFAULT);
    CURL *curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        // We only want the heartbeat, no need to download the response body
        curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);

        while(true) {
            CURLcode res = curl_easy_perform(curl);
            
            if(res != CURLE_OK) {
                std::cerr << "Ping failed: " << curl_easy_strerror(res) << std::endl;
            } else {
                long response_code;
                curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &response_code);
                std::cout << "Ping successful, Status: " << response_code << std::endl;
            }
            
            // Sleep for the configured interval
            std::this_thread::sleep_for(std::chrono::minutes(interval_minutes));
        }
        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
    
    return 0;
}
