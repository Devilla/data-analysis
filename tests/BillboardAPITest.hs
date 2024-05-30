{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import BillboardAPI (getBillboardData)
import Data.Maybe (isJust)

main :: IO ()
main = hspec $ do
  describe "getBillboardData" $ do
    it "returns a non-empty ByteString" $ do
      result <- getBillboardData
      result `shouldSatisfy` isJust

    it "returns a valid JSON response" $ do
      result <- getBillboardData
      result `shouldSatisfy` isJust