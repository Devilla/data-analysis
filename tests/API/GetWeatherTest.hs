{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import GetWeather (getWeather)
import Data.Aeson (decode, Value)
import Data.Maybe (isJust)
import qualified Data.ByteString.Lazy as L

main :: IO ()
main = hspec $ do
  describe "getWeather" $ do
    it "returns a non-empty ByteString" $ do
      result <- getWeather
      L.length result `shouldSatisfy` (> 0)

    it "returns a valid JSON response" $ do
      result <- getWeather
      (decode result :: Maybe Value) `shouldSatisfy` isJust