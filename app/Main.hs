module Main (main) where

import LinearRegression

main :: IO ()
main = do
  let dataset = [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6)]
  let regressionResult = linearRegression dataset
  case regressionResult of
    Just result -> do
      let xValue = 8
          predictedValue = predict result xValue
      putStrLn $ "Linear regression result: " ++ show result
      putStrLn $ "Predicted value for x = " ++ show xValue ++ ": " ++ show predictedValue
    Nothing ->
      putStrLn "Linear regression failed"