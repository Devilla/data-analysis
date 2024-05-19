{-# LANGUAGE OverloadedStrings #-}

import Network.HTTP.Simple
import Data.Aeson
import Data.Aeson.Lens
import Control.Lens

-- Define your API credentials
apiKey :: String
apiKey = "your-api-key"

sharedSecret :: String
sharedSecret = "your-shared-secret"

-- Define the API endpoint
apiEndpoint :: String
apiEndpoint = "http://platform.fatsecret.com/rest/server.api"

-- Function to make a GET request to the FatSecret API
getFromFatSecret :: String -> IO (Maybe Value)
getFromFatSecret method = do
    -- Build the request
    let request = setRequestMethod "GET"
                $ setRequestQueryString [("method", Just method), ("format", Just "json"), ("oauth_consumer_key", Just $ pack apiKey)]
                $ parseRequest_ apiEndpoint

    -- Send the request and get the response
    response <- httpJSON request

    -- Extract the JSON body from the response
    let jsonBody = getResponseBody response

    -- Return the JSON body
    return $ jsonBody ^? _Object

-- Function to get food information
getFood :: String -> IO (Maybe Value)
getFood foodId = getFromFatSecret $ "food.get.v2&food_id=" ++ foodId