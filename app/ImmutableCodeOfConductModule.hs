module ImmutableCodeOfConductModule where
-- Add the module to the other-modules or exposed-modules section in the .cabal file

-- Define a type for the rules. For simplicity, we'll represent rules as strings.
type Rule = String

-- Define the immutable, hard-coded rules of the Code of Conduct
fixedRules :: [Rule]
fixedRules = [ "Respect user privacy",
               "Avoid illegal activities",
               "Ensure fairness and transparency",
               "Do not propagate false information",
               "Maintain professional integrity" ]