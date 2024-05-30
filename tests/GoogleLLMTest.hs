{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import GoogleLLM
import Data.Aeson
import Data.Maybe (isJust)
import qualified Data.ByteString.Lazy as L

main :: IO ()
main = hspec $ do
  describe "generateContent" $ do
    it "returns a non-empty ByteString" $ do
      result <- generateContent
      L.length (L.fromStrict result) `shouldSatisfy` (> 0)

    it "returns a valid JSON response" $ do
      result <- generateContent
      (decode (L.fromStrict result) :: Maybe Value) `shouldSatisfy` isJust