{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

module GetWeather
  ( Weather(..)
  , Location(..)
  , Current(..)
  , getWeatherData
  , getWeather
  , storeWeatherData
  ) where

import Network.HTTP.Simple
import qualified Data.Aeson as A
import qualified Data.Aeson.Types as AT
import qualified Data.ByteString.Lazy.Char8 as BL

data Weather = Weather {
    location :: Location,
    current :: Current
} deriving Show

data Location = Location {
    localtime :: String
} deriving Show

data Current = Current {
    temp_c :: Float
} deriving Show

instance A.FromJSON Weather where
    parseJSON = A.withObject "Weather" $ \v -> Weather
        <$> v AT..: "location"
        <*> v AT..: "current"

instance A.FromJSON Location where
    parseJSON = A.withObject "Location" $ \v -> Location
        <$> v AT..: "localtime"

instance A.FromJSON Current where
    parseJSON = A.withObject "Current" $ \v -> Current
        <$> v AT..: "temp_c"

getWeather :: IO BL.ByteString
getWeather = do
    request <- parseRequest "https://api.weatherapi.com/v1/current.json?key=d85eb9c9c3b544988b3123644242205%20&q=New%20York&aqi=no"
    response <- httpLBS request
    return $ getResponseBody response

storeWeatherData :: IO ()
storeWeatherData = do
    weatherData <- getWeather
    BL.writeFile "data/weather_data.json" weatherData

getWeatherData :: IO (Maybe Weather)
getWeatherData = do
    weatherData <- BL.readFile "data/weather_data.json"
    return $ A.decode weatherData