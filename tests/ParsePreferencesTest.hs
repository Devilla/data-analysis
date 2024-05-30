{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import ParsePreferences ( getFoodPreferences )
import Data.Maybe (isJust)

main :: IO ()
main = hspec $ do
  describe "parsePreferences" $ do
    it "returns a non-empty list" $ do
      result <- getFoodPreferences
      length result `shouldSatisfy` (> 0)

    it "returns a valid preference" $ do
      result <- getFoodPreferences
      result `shouldSatisfy` isJust