module LinearRegression  (unaryLinearRegression , predict) where

import Data.List (foldl') 
import Data.Fixed (fixed)

unaryLinearRegression :: [(Double, Double)] -> Maybe (Double, Double)
unaryLinearRegression [] = Nothing
unaryLinearRegression points =
  let n = fromIntegral $ length points
      (sumX, sumY, sumXY, sumX2) = foldl' accumulate (0, 0, 0, 0) points
      accumulate (sX, sY, sXY, sX2) (x, y) = (sX + x, sY + y, sXY + x * y, sX2 + x * x)
      slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX)
      intercept = (sumY - slope * sumX) / n
  in Just (slope, intercept)

predict :: (Double, Double) -> Double -> Double
predict (slope, intercept) x = fixed 3 (intercept + slope * x)