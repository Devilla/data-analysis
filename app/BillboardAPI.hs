{-# LANGUAGE OverloadedStrings #-}

module BillboardAPI where

import Network.HTTP.Simple
import Data.Aeson
import qualified Data.ByteString.Char8 as B8
import Data.String (IsString)


getBillboardData :: IO (Maybe Value)
getBillboardData = do
    initReq <- parseRequest "https://billboard-api2.p.rapidapi.com/hot-100"
    let headers = [ ("X-RapidAPI-Key", "SIGN-UP-FOR-KEY")
                  , ("X-RapidAPI-Host", "billboard-api2.p.rapidapi.com")
                  ]

    let query = [ ("date", Just "2019-05-11")
                , ("range", Just "1-10")
                ]
    let req = setRequestHeaders headers $ setRequestQueryString query initReq
    response <- httpJSON req
    return $ getResponseBody response

main :: IO ()
main = do
    result <- getBillboardData
    case result of
        Just v  -> print v
        Nothing -> putStrLn "Error fetching data"