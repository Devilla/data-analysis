{-# LANGUAGE OverloadedStrings #-}

module BillboardAPI where

import Network.HTTP.Simple
import Data.Aeson
import qualified Data.ByteString.Char8 as B8

getBillboardData :: IO (Maybe Value)
getBillboardData = do
    initReq <- parseRequest "https://billboard-api2.p.rapidapi.com/hot-100"
    let headers = [ ("X-RapidAPI-Key", "52b29054d8mshcfaf2b2d8f67011p150926jsn0bad01b0689d")
                  , ("X-RapidAPI-Host", "billboard-api2.p.rapidapi.com")
                  ]
    let query = [ ("date", Just $ B8.pack "2019-05-11")
                , ("range", Just $ B8.pack "1-10")
                ]
    let req = setRequestHeaders headers $ setRequestQueryString query initReq
    response <- httpJSON req
    return $ getResponseBody response