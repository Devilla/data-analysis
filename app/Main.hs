
module Main where

import SerpAPI
import Prelude hiding (print)
import qualified Data.Aeson as Aeson
import qualified Data.ByteString.Lazy as BL

main :: IO ()
main = do
    res <- getFromSerpApi "fruits in Himachal Pradesh"

    -- Convert res into a JSON ByteString
    let json = Aeson.encode res

    -- Write the JSON ByteString to a file
    BL.writeFile "data/output.json" json



-- The main function of the application
