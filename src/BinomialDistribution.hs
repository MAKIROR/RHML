module BinomialDistribution (binomialLikelihood, findMLE) where

import Data.List

binomialLikelihood :: [Int] -> Double -> Double
binomialLikelihood observations p = sum [log (choose n k) + fromIntegral k * log p + fromIntegral (n - k) * log (1 - p) | k <- observations]
  where 
      n = fromIntegral $ length observations
      choose :: Int -> Int -> Double
      choose n k = factorial n / (factorial k * factorial (n - k))
      factorial 0 = 1
      factorial m = fromIntegral m * factorial (m - 1)

likelihoodForP :: [Int] -> Double -> Double
likelihoodForP xs p = binomialLikelihood xs p

findMLE :: [Int] -> Double
findMLE xs = maximumBy (\p1 p2 -> compare (likelihoodForP xs p1) (likelihoodForP xs p2)) [0.01, 0.02 .. 0.99]