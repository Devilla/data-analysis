{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GADTs #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

module GoogleLLM where


import Network.HTTP.Conduit
import Network.HTTP.Types.Method
import Data.Aeson
import Data.ByteString (ByteString)
import qualified Data.ByteString.Lazy as L
import GHC.Generics

data Content = Content
  { contents :: [Parts]
  } deriving (Show, Generic)

data Parts = Parts
  { parts :: [Part]
  } deriving (Show, Generic)

data Part = Part
  { text :: String
  } deriving (Show, Generic)

instance ToJSON Content
instance ToJSON Parts
instance ToJSON Part

-- | Generates content by making a POST request to the Google Language Models API.
-- The generated content is based on the provided input.
generateContent :: String -> IO ByteString
generateContent prompt = do
  manager <- newManager tlsManagerSettings
  initReq <- parseRequest "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyBY8TKtP7eOsqPg8M-4YK5bz3mQB_n7m4I"
  let content = Content [Parts [Part prompt]]
      reqBody = RequestBodyLBS (encode content)
      headers = [("Content-Type", "application/json")]
      request = initReq { method = methodPost, requestBody = reqBody, requestHeaders = headers }
  response <- httpLbs request manager
  return $ L.toStrict $ responseBody response