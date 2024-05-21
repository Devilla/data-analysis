
module Main where

import SerpAPI ( getFromSerpApi )
import HighLevel
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

    -- Read the high-level data from the files
    highLevelMain <- readPreferences "data/preferences.json"
    ingredients <- readIngredients "data/ingredients.json"
    log <- readLog "data/log.json"

    let aggregatedData = aggregateData highLevelMain ingredients log

    adjustedData <- adjustForRealTime aggregatedData

    print adjustedData

-- Print the aggregated data

print :: AggregatedData -> IO ()
print (AggregatedData meanCalories modeCuisine) = do
    putStrLn $ "Mean calories: " ++ show meanCalories
    putStrLn $ "Mode cuisine: " ++ modeCuisine


-- The main function of the application

