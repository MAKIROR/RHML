module Main (main) where

import LinearRegression

main :: IO ()
main = do
  let dataset = [(0.2, 2.7), (1.2, 3.6), (2.3, 4.5), (2.8, 6.3), (3.5, 5.9), (3.8, 7.3), (3.9, 8.4), (5.1, 9.5), (5.3, 11.2), (4.9, 12.7)]
  let regressionResult = unaryLinearRegression dataset
  case regressionResult of
    Just result -> do
      let x = 4
          predictedValue = predict result x
      putStrLn $ "Linear regression result: " ++ show result
      putStrLn $ "Predicted value for x = " ++ show x ++ ": " ++ show predictedValue
    Nothing ->
      putStrLn "Linear regression failed"