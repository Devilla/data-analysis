
module Main where

import SerpAPI
import Prelude hiding (print)
import Prelude (print)

main :: IO ()
main = do
    res <- getFromSerpApi "restaurants in New York"
    print res



-- The main function of the application
