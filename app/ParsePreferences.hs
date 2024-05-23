-- ParsePreferences.hs
{-# LANGUAGE OverloadedStrings #-}
module ParsePreferences
  ( FoodPreferences(..)
  , getFoodPreferences
  ) where
-- rest of your code...

import qualified Data.Aeson as A
import qualified Data.Aeson.Types as AT
import qualified Data.ByteString.Lazy.Char8 as BL

data FoodPreferences = FoodPreferences {
    preferred_foods :: [String],
    preferred_cuisines :: [String],
    max_calories :: Int
} deriving Show

instance A.FromJSON FoodPreferences where
    parseJSON = A.withObject "FoodPreferences" $ \v -> FoodPreferences
        <$> v AT..: "preferred_foods"
        <*> v AT..: "preferred_cuisines"
        <*> v AT..: "max_calories"

getFoodPreferences :: IO (Maybe FoodPreferences)
getFoodPreferences = do
    foodData <- BL.readFile "data/food_preferences_by_temperature.json"
    mealData <- BL.readFile "data/meal_preferences.json"
    let foodPrefs = A.decode foodData :: Maybe FoodPreferences
    let mealPrefs = A.decode mealData :: Maybe FoodPreferences
    return $ mergePreferences foodPrefs mealPrefs

mergePreferences :: Maybe FoodPreferences -> Maybe FoodPreferences -> Maybe FoodPreferences
mergePreferences (Just fp1) (Just fp2) = Just FoodPreferences {
    preferred_foods = preferred_foods fp1 ++ preferred_foods fp2,
    preferred_cuisines = preferred_cuisines fp1 ++ preferred_cuisines fp2,
    max_calories = max (max_calories fp1) (max_calories fp2)
}
mergePreferences fp1 Nothing = fp1
mergePreferences Nothing fp2 = fp2
mergePreferences _ _ = Nothing

-- [Teperature] [Time] [Location] [Food] [Cuisine] [Calories] [Billboard Top Artist] [Hoemetown] [prefferences] [restrictictions]