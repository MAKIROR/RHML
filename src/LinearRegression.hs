module LinearRegression (linearRegression, predict) where

import Data.List (foldl')

type DataPoint = (Double, Double)

linearRegression :: [DataPoint] -> Maybe (Double, Double)
linearRegression [] = Nothing
linearRegression points =
  let n = fromIntegral $ length points
      (sumX, sumY, sumXY, sumX2) = foldl' accumulate (0, 0, 0, 0) points
      accumulate (sX, sY, sXY, sX2) (x, y) = (sX + x, sY + y, sXY + x * y, sX2 + x * x)
      slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX)
      intercept = (sumY - slope * sumX) / n
  in Just (slope, intercept)

predict :: (Double, Double) -> Double -> Double
predict (slope, intercept) x = intercept + slope * x