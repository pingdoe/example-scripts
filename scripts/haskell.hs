-- Requires http-conduit package: cabal install http-conduit
import Network.HTTP.Simple
import Control.Concurrent (threadDelay)
import Control.Monad (forever)
import Data.Time.Clock (getCurrentTime)
import Control.Exception (try, SomeException)

main :: IO ()
main = do
    let url = "https://pingdoe.com/ping/6a53bb50-c4ab-486f-99da-1fbb50194d18"
    let intervalMinutes = 5
    
    putStrLn $ "Starting PingDoe heartbeat every " ++ show intervalMinutes ++ " minutes..."
    
    forever $ do
        now <- getCurrentTime
        
        -- Catching exceptions so the loop doesn't crash on network failure
        result <- try (httpLBS (parseRequest_ url)) :: IO (Either SomeException (Response ()))
        
        case result of
            Left ex -> 
                putStrLn $ "[" ++ show now ++ "] Ping failed: " ++ show ex
            Right response -> 
                putStrLn $ "[" ++ show now ++ "] Ping successful: " ++ show (getResponseStatusCode response)
                
        threadDelay (intervalMinutes * 60 * 1000000)
