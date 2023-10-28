module GaussianNaiveBayes(predictCategory, trainModel) where

import Probability.GaussianProbability
import Data.List(maximumBy)

type Document = [Double]
type Class = String
type ClassStats = [(Double, Double)]

priorProbability :: [Class] -> Class -> Double
priorProbability categories category =
    let totalDocs = length categories
        categoryCount = length (filter (== category) categories)
    in fromIntegral categoryCount / fromIntegral totalDocs

trainModel :: [(Class, [Document])] -> Class -> ClassStats
trainModel trainingData category =
    let documents = concatMap snd $ filter (\(c, _) -> c == category) trainingData
        numFeatures = length (head documents)
    in [calculateClassStats [feature !! i | feature <- documents] | i <- [0..numFeatures - 1]]

predictCategory :: [Double] -> [(Class, ClassStats)] -> Class
predictCategory document classStats =
    let posteriorProbs = map (\(category, stats) -> (category, priorProbability (map fst classStats) category * product (zipWith (\feature stat -> gaussianProbability feature stat) document stats))) classStats
        (maxCategory, _) = maximumBy (\(_, p1) (_, p2) -> compare p1 p2) posteriorProbs
    in maxCategory