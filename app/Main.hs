module Main (main) where

import LinearRegression

main :: IO ()
main = do
  let dataset = [(1, 2), (2, 3), (3, 4), (4, 5), (5, 6)]
  let result = linearRegression dataset
  putStrLn $ "Linear regression result: " ++ show result