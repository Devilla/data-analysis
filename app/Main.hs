{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant return" #-}


module Main where

import SerpAPI ( getFromSerpApi )
import Prelude
import qualified Data.Aeson as Aeson
import qualified Data.ByteString.Lazy as BL
import GoogleLLM (generateContent)


jsonFile :: FilePath
jsonFile = "data/meal_preferences.json"

getJSON :: IO BL.ByteString
getJSON = BL.readFile jsonFile

main :: IO ()
main = do
    res <- getFromSerpApi "current temperature in New York in degrees celcius"
    
    -- Lady gaga hometown cuisine, current temperature in new york"

    -- Convert res into a JSON ByteString
    let json = Aeson.encode res

    -- Write the JSON ByteString to a file
    BL.writeFile "data/real_time_output.json" json

    -- Read the JSON ByteString from the file
    -- getJSON >>= \jsonFromFile -> do
    --     print jsonFromFile


    -- Generate content using the Google LLM API
    generateContent >>= \content -> do
        print content

    

