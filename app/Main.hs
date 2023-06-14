module Main (main) where

import LinearRegression

main :: IO ()
main = do
  let dataset = [(1, 2.1), (1.5, 3.2), (2, 4.3), (2.5, 5.4), (3, 6.5), (3.5, 7.6), (4, 8.7), (4.5, 9.8), (5, 10.9), (5.5, 12.0)]
  let regressionResult = unaryLinearRegression dataset
  case regressionResult of
    Just result -> do
      let x = 8
          predictedValue = predict result x
      putStrLn $ "Linear regression result: " ++ show result
      putStrLn $ "Predicted value for x = " ++ show x ++ ": " ++ show predictedValue
    Nothing ->
      putStrLn "Linear regression failed"