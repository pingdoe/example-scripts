(ns pingdoe.heartbeat
  (:require [clj-http.client :as client]))

;; EXAMPLE link replace with own url
(def url "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18")
(def interval-minutes 5)

(println (str "Starting PingDoe heartbeat every " interval-minutes " minutes..."))

(defn send-ping []
  (let [timestamp (java.util.Date.)]
    (try
      (let [response (client/get url {:throw-exceptions false})]
        (println (str "[" timestamp "] Ping successful: " (:status response))))
      (catch Exception e
        (println (str "[" timestamp "] Ping failed: " (.getMessage e)))))))

(defn -main []
  (loop []
    (send-ping)
    (Thread/sleep (* interval-minutes 60 1000))
    (recur)))

(-main)
