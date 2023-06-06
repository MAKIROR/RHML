module LinearRegression where

import Data.List (foldl')
import Control.Monad (replicateM)

data LinearRegressionModel = LinearRegressionModel
{ 
    weights :: [Double],
    bias :: Double
}

fit :: [(Double, Double)] -> LinearRegression