module Probability.GaussianProbability ( gaussianProbability, calculateClassStats) where

gaussianProbability :: Double -> (Double, Double) -> Double
gaussianProbability x (mean, variance) =
    (1.0 / (sqrt (2.0 * pi * variance))) * exp (-((x - mean) ** (2.0 :: Double)) / (2.0 * variance))

calculateClassStats :: [Double] -> (Double, Double)
calculateClassStats values =
    let mean = sum values / fromIntegral (length values)
        variance = sum [(x - mean) ** (2.0 :: Double) | x <- values] / fromIntegral (length values)
    in (mean, variance)