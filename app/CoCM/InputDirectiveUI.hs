{-# LANGUAGE OverloadedStrings #-}

module InputDirectiveUI where

import qualified Data.Map as Map
import qualified Data.Text as T
import System.IO (hFlush, stdout)

-- Assuming these types and functions are defined in their respective modules
-- type Rule = String
-- type Industry = String
-- getICoCMRules :: IO [Rule]
-- getSCoCMRules :: Industry -> IO [Rule]

type UserID = String
type Directive = String
type UserSpecificDatabase = Map.Map UserID [Directive]

-- Simulate a database in memory (for demonstration)
userSpecificDatabase :: UserSpecificDatabase
userSpecificDatabase = Map.empty

-- Function to add a directive for a user, ensuring it yields to iCoCM and sCoCM
addDirective :: UserID -> Industry -> Directive -> UserSpecificDatabase -> IO UserSpecificDatabase
addDirective userId industry directive db = do
  iCoCMRules <- getICoCMRules
  sCoCMRules <- getSCoCMRules industry
  let conflicts = directive `elem` (iCoCMRules ++ sCoCMRules)
  if conflicts
    then do
      putStrLn "Directive conflicts with existing rules. Please revise."
      return db
    else return $ Map.insertWith (++) userId [directive] db

-- UI function to input personal directives
inputDirectiveUI :: UserID -> Industry -> UserSpecificDatabase -> IO UserSpecificDatabase
inputDirectiveUI userId industry db = do
  putStrLn "Enter your personal directive:"
  hFlush stdout
  directive <- getLine
  addDirective userId industry directive db

-- Example usage
main :: IO ()
main = do
  let userId = "user123"
  let industry = "Technology"
  db <- inputDirectiveUI userId industry userSpecificDatabase
  putStrLn "Directive added successfully (if no conflicts)."