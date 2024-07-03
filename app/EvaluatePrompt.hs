{-# LANGUAGE OverloadedStrings #-}

module EvaluatePrompt where

import Control.Monad (when)
import Data.List (intersect)
import Data.Maybe (catMaybes)

-- Assuming these functions are defined in their respective modules
getICoCMRules :: IO [String]
getSCoCMRules :: IO [String]
getUCoCMRules :: IO [String]
classifyPrompt :: String -> IO String

-- Function to evaluate a prompt
evaluatePrompt :: String -> IO (Bool, [String])
evaluatePrompt prompt = do
  -- Fetch rules from iCoCM, sCoCM, and uCoCM
  iCoCMRules <- getICoCMRules
  sCoCMRules <- getSCoCMRules
  uCoCMRules <- getUCoCMRules
  let combinedRules = concat [iCoCMRules, sCoCMRules, uCoCMRules]

  -- Use classifyPrompt to evaluate the prompt
  classification <- classifyPrompt prompt

  -- Check compliance with the combined set of rules
  let isCompliant = classification == "valid"
  let nonCompliantRules = if isCompliant then [] else intersect combinedRules [classification]

  -- Return compliance result and any necessary actions
  return (isCompliant, nonCompliantRules)