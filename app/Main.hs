module Main (main) where

import BinomialDistribution

main :: IO ()
main = do
    let observations = [1,0]
    let likelihood = BinomialDistribution.findMLE observations
    putStrLn $ "Likelihood: " ++ show likelihood 