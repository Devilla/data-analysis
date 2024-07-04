module SetCodeOfConductModule where
-- Add SetCodeOfConductModule to other-modules or exposed-modules in the .cabal file

import qualified Data.Map as Map

-- Define a type for the rules and for the industry sectors
type Rule = String
type Industry = String

-- Define a type for the Set Code of Conduct Module, which maps an industry to its specific rules
type SCOCM = Map.Map Industry [Rule]

-- Example industries with their specific rules
healthcareRules :: [Rule]
healthcareRules = [ "Protect patient confidentiality",
                    "Provide accurate and timely medical information",
                    "Ensure patient safety and well-being" ]

financeRules :: [Rule]
financeRules = [ "Ensure the accuracy of financial reporting",
                 "Protect customer financial information",
                 "Comply with financial regulations and laws" ]

technologyRules :: [Rule]
technologyRules = [ "Promote digital accessibility and inclusion",
                    "Ensure data security and privacy",
                    "Support open and ethical AI development" ]

-- Populate the Set Code of Conduct Module with example rules for different industries
sCoCM :: SCOCM
sCoCM = Map.fromList [ ("Healthcare", healthcareRules),
                       ("Finance", financeRules),
                       ("Technology", technologyRules) ]

-- Function to select guidelines based on the Aiver's role (industry)
selectGuidelines :: Industry -> Maybe [Rule]
selectGuidelines industry = Map.lookup industry sCoCM