import GaussianNaiveBayes
import Data.Function (on)
import Data.List (maximumBy)

main :: IO ()
main = do
    let trainingData = [("Class1", [[1.0, 2.0], [2.0, 3.0], [3.0, 4.0]]),
                        ("Class2", [[2.0, 3.0], [3.0, 4.0], [4.0, 5.0]])]
    let classStats = map (\(category, _) -> (category, trainModel trainingData category)) trainingData
    let testDocument = [2.5, 3.5]
    let predictedCategory = predictCategory testDocument classStats
    putStrLn $ "Predicted Category: " ++ predictedCategory