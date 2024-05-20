
module Main where

import SerpAPI
import qualified Data.Aeson as Data.Aeson.Types.Internal


main :: IO (Maybe Data.Aeson.Types.Internal.Value)
main = do
    SerpAPI.getFromSerpApi "fruits"


-- The main function of the application
