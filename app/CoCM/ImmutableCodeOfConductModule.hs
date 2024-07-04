module ImmutableCodeOfConductModule where
-- Add the module to the other-modules or exposed-modules section in the .cabal file

-- Define a type for the rules. For simplicity, we'll represent rules as strings.
type Rule = String

-- Define the immutable, hard-coded rules of the Code of Conduct
fixedRules :: [Rule]
fixedRules = [  "Respect user privacy",
               "Avoid illegal activities",
               "Ensure fairness and transparency",
               "Do not propagate false information",
               "Maintain professional integrity" ]

-- Function to retrieve the immutable rules of the Code of Conduct
getFixedRules :: IO [Rule]
getFixedRules = return fixedRules

-- Function to add a new rule to the immutable rules list
addFixedRule :: Rule -> IO [Rule]
addFixedRule newRule = return (newRule : fixedRules)

-- -- Function to remove a rule from the immutable rules list
-- removeFixedRule :: Rule -> IO [Rule]
-- removeFixedRule ruleToRemove = return (filter (/= ruleToRemove) fixedRules)

-- -- Function to update a rule in the immutable rules list
-- updateFixedRule :: Rule -> Rule -> IO [Rule]
-- updateFixedRule oldRule newRule = return (map (\r -> if r == oldRule then newRule else r) fixedRules)

-- Function to check if a rule is present in the immutable rules list
isRulePresent :: Rule -> IO Bool
isRulePresent rule = return (rule `elem` fixedRules)

-- Function to get the index of a rule in the immutable rules list
getRuleIndex :: Rule -> IO (Maybe Int)
getRuleIndex rule = return (elemIndex rule fixedRules)
  where
    elemIndex :: Eq a => a -> [a] -> Maybe Int
    elemIndex _ [] = Nothing
    elemIndex x (y:ys) = if x == y then Just 0 else fmap (+1) (elemIndex x ys)

-- Function to get the total number of immutable rules
getTotalFixedRules :: IO Int
getTotalFixedRules = return (length fixedRules)

-- Function to get a specific rule from the immutable rules list
getFixedRule :: Int -> IO (Maybe Rule)

getFixedRule index
  | index >= 0 && index < length fixedRules = return (Just (fixedRules !! index))
  | otherwise = return Nothing

-- Function to get all immutable rules that contain a specific keyword
getRulesByKeyword :: String -> IO [Rule]
getRulesByKeyword keyword = return (filter (isKeywordInRule keyword) fixedRules)
  where
    isKeywordInRule :: String -> Rule -> Bool
    isKeywordInRule k r = k `elem` words r
