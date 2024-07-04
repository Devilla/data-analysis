{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}

module FatSecretAPI where

import Network.HTTP.Simple
import Network.HTTP.Types.URI (urlEncode)
import Crypto.Hash (SHA1, Digest)
import Crypto.MAC.HMAC
import Data.ByteString (ByteString)
import qualified Data.ByteString.Char8 as C
import qualified Data.ByteString.Base64 as B64
import Data.Time.Clock.POSIX

-- FatSecret API credentials
api_key :: ByteString
api_key = "2ea743ba91a848f1bab1d625af438617"

shared_secret :: ByteString
shared_secret = "b6e0de0a163c4f3296e2f16cf22a3364"

-- Base URL for FatSecret API
base_url :: ByteString
base_url = "http://platform.fatsecret.com/rest/server.api"

-- Generate OAuth parameters
oauth_nonce :: ByteString
oauth_nonce = "random_nonce" -- replace with actual nonce generation

oauth_timestamp :: IO ByteString
oauth_timestamp = fmap (C.pack . show . round) getPOSIXTime

oauth_signature_method :: ByteString
oauth_signature_method = "HMAC-SHA1"

oauth_version :: ByteString
oauth_version = "1.0"

-- Prepare string to sign
base_string :: IO ByteString
base_string = do
    let url = "http://platform.fatsecret.com/rest/server.api"
    let encodedUrl = urlEncode False url
    timestamp <- oauth_timestamp
    return $ C.concat ["GET&", urlEncode False encodedUrl, "&", urlEncode False (C.concat ["format=json&method=foods.search&oauth_consumer_key=", api_key, "&oauth_nonce=", oauth_nonce, "&oauth_signature_method=", oauth_signature_method, "&oauth_timestamp=", timestamp, "&oauth_version=", oauth_version, "&search_expression=pizza"])]

-- Generate OAuth signature
oauth_signature :: IO ByteString
oauth_signature = do
    stringToSign <- base_string
    let signature = hmacGetDigest $ hmac shared_secret stringToSign :: Digest SHA1
    return $ B64.encode $ C.pack $ show signature

-- Prepare API request URL
apiUrl :: IO ByteString
apiUrl = do
    signature <- oauth_signature
    timestamp <- oauth_timestamp
    return $ C.concat [base_url, "?format=json&method=foods.search&oauth_consumer_key=", api_key, "&oauth_nonce=", oauth_nonce, "&oauth_signature_method=", oauth_signature_method, "&oauth_signature=", urlEncode True signature, "&oauth_timestamp=", timestamp, "&oauth_version=", oauth_version, "&search_expression=pizza"]

-- Make API request
main :: IO ()
main = do
    requestUrl <- apiUrl
    request <- parseRequest $ C.unpack requestUrl
    response <- httpBS request
    print $ getResponseBody response