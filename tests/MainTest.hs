{-# LANGUAGE OverloadedStrings #-}

module MainTest where

import Test.Hspec
import Main
import GetWeather
import GoogleLLM
import Data.Aeson (encode)
import qualified Data.ByteString as B

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
  -- describe "getWeatherData" $ do
  --   it "returns weather data for a given location" $ do
  --     let location = "New York"
  --     weatherData <- getWeatherData
  --     location weatherData `shouldBe` location

  -- describe "generateContent" $ do
  --   it "generates content based on meal preferences and weather data" $ do
  --     let mealPreference = MealPreference "12:00" ["Italian", "Mexican"]
  --     let weatherData = Weather (Location "London") (Current 20)
  --     content <- generateContent (show mealPreference)
  --     content `shouldSatisfy` (not . B.null)

  describe "getPreferredCuisines" $ do
    it "returns preferred cuisines for a given time" $ do
      let time = "12:00"
      cuisines <- getPreferredCuisines time
      cuisines `shouldSatisfy` (not . null)

  -- describe "getFoodPreferences" $ do
  --   it "returns preferred foods for a given temperature" $ do
  --     let temperature = 20
  --     foods <- getFoodPreferences temperature
  --     foods `shouldSatisfy` (not . null)