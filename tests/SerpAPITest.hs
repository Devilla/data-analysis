{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import SerpAPI (getSearchResults)
import Data.Aeson (Value)
import Data.Maybe (isJust)

main :: IO ()
main = hspec $ do
  describe "getSearchResults" $ do
    it "returns a non-empty ByteString" $ do
      result <- getSearchResults "query"
      result `shouldSatisfy` isJust

    it "returns a valid JSON response" $ do
      result <- getSearchResults "query"
      (result :: Maybe Value) `shouldSatisfy` isJust