module ProtectiveRules (protectiveRules) where

import Data.Char (toLower)
import Data.List (isInfixOf)

-- List of harmful or nonsensical keywords/patterns
harmfulPatterns :: [String]
harmfulPatterns = ["harmful", "nonsensical", "inappropriate"]

-- Function to check if the prompt contains any harmful patterns
isHarmfulPrompt :: String -> Bool
isHarmfulPrompt prompt = any (`isInfixOf` map toLower prompt) harmfulPatterns

-- Protective rule function that either blocks the prompt or allows it
protectiveRules :: String -> Either String String
protectiveRules prompt
  | isHarmfulPrompt prompt = Left "This prompt violates the aCoCM."
  | otherwise = Right prompt
  --instance not mentioned yet in the main.hs file for calling the protectiveRules function