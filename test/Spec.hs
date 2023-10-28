import GaussianNaiveBayes
import Data.Function (on)
import Data.List (maximumBy)

main :: IO ()
main = do
    let trainingData = [("Class1", [[1.2, 2.3], [1.4, 2.9], [1.5, 2.7], [1.3, 2.6]]),
                        ("Class2", [[2.0, 3.1], [2.1, 3.5], [2.2, 3.3], [2.3, 3.4]]),
                        ("Class3", [[3.0, 4.1], [3.1, 4.5], [3.2, 4.3], [3.3, 4.4]])]

    let classStats = map (\(category, _) -> (category, trainModel trainingData category)) trainingData
    let testDocument = [2.2, 3.2]
    let predictedCategory = predictCategory testDocument classStats
    putStrLn $ "Predicted Category: " ++ predictedCategory