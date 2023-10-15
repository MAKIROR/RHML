module LinearRegression (unaryLinearRegression , predict) where

import Data.List (foldl')

formatFloat :: Double -> Double
formatFloat x = fromIntegral (round (x * 1000) :: Integer) / 1000

unaryLinearRegression :: [(Double, Double)] -> Maybe (Double, Double)
unaryLinearRegression [] = Nothing
unaryLinearRegression points =
  let n = fromIntegral $ length points
      (sumX, sumY, sumXY, sumX2) = foldl' accumulate (0, 0, 0, 0) points
      accumulate (sX, sY, sXY, sX2) (x, y) = (sX + x, sY + y, sXY + x * y, sX2 + x * x)
      slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX)
      intercept = (sumY - slope * sumX) / n
  in Just (formatFloat slope, formatFloat intercept)

predict :: (Double, Double) -> Double -> Double
predict (slope, intercept) x = formatFloat intercept + slope * x