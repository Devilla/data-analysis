{-# LANGUAGE OverloadedStrings #-}


import Network.HTTP.Simple
import Data.Aeson (FromJSON)
import Data.Aeson.Lens (_Object)
import Control.Lens (preview)
import Data.Aeson (Value, Object)
import Data.ByteString.Char8 (pack, ByteString)


main :: IO ()
main = do
    putStrLn "Hello, Haskell!"
    food <- getFood "1001"
    print food




-- Define your API credentials
apiKey :: String
apiKey = "daa7bbf818d24eb7a38ef34aae97c247"

sharedSecret :: String
sharedSecret = "56da081e0f8a472cb2e70c2460073f87"

-- Define the API endpoint
apiEndpoint :: String
apiEndpoint = "http://platform.fatsecret.com/rest/server.api"

-- Function to make a GET request to the FatSecret API
getFromFatSecret :: String -> IO (Maybe Object)
getFromFatSecret method = do
    -- Build the request
    let request = setRequestMethod "GET"
                $ setRequestQueryString [("method", Just $ pack method), ("format", Just "json"), ("oauth_consumer_key", Just $ pack apiKey)]
                $ parseRequest_ apiEndpoint

    -- Send the request and get the response
    -- response <- httpJSON request

    response <- httpJSON request :: IO (Response Value)

    -- Extract the JSON body from the response
    let jsonBody = getResponseBody response

    -- Return the JSON body
    return $ preview _Object jsonBody

-- Function to get food information
getFood :: String -> IO (Maybe Object)
getFood foodId = getFromFatSecret $ "food.get.v2&food_id=" ++ foodId
