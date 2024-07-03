{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module ClassifyPrompt where

import Network.HTTP.Simple
import Data.Aeson
import GHC.Generics

-- Define a data structure for the request body
data PromptRequest = PromptRequest
  { prompt :: String
  } deriving (Generic, Show)

instance ToJSON PromptRequest

-- Define a data structure for the response
data ClassificationResponse = ClassificationResponse
  { classification :: String
  } deriving (Generic, Show)

instance FromJSON ClassificationResponse

-- Function to classify a prompt using an external DistilBERT model
classifyPrompt :: String -> IO (Maybe String)
classifyPrompt promptText = do
  let request = setRequestMethod "POST"
              $ setRequestHeader "Content-Type" ["application/json"]
              $ setRequestBodyJSON (PromptRequest promptText)
              $ "http://example.com/classify"
  response <- httpJSON request
  let classification = getResponseBody response :: ClassificationResponse
  return $ Just (classification classification)