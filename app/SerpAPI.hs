{-# LANGUAGE OverloadedStrings #-}
module SerpAPI where

import Network.HTTP.Simple
    ( parseRequest_,
      getResponseBody,
      httpJSON,
      setRequestMethod,
      setRequestQueryString )
import Data.Aeson ( Value )
import qualified Data.ByteString.Char8 as B


-- Define the API endpoint
apiEndpoint :: String
apiEndpoint = "https://serpapi.com/search.json?engine=google_maps&q=fruits&type=search"

-- Function to make a GET request to the SerpApi
getFromSerpApi :: String -> IO (Maybe Value)
getFromSerpApi query = do
    -- Build the request
    let request = setRequestMethod "GET"
            $ setRequestQueryString [("engine", Just "google"), ("q", Just $ B.pack query), ("api_key", Just $ B.pack "4621be6f7962e9a08c9aca475f96b344bd604f31aacf6dea5dc073e21eed3482")]
            $ parseRequest_ apiEndpoint

    -- Send the request and get the response
    response <- httpJSON request

    -- Extract the JSON body from the response
    let jsonBody = getResponseBody response
    -- Return the JSON body
    return $ Just jsonBody

-- Function to get search results
getSearchResults :: String -> IO (Maybe Value)
getSearchResults = getFromSerpApi