module TextCategorization (
    DocumentClass(..), 
    Document, 
    classifyDocument,
    calculateCategoryProbability,
    calculateWordProbabilities
    ) where

import Data.Map (fromListWith, toList)
import Data.List (nub)

data DocumentClass = Positive | Negative | Neutral deriving (Eq, Show)
type Document = (DocumentClass, [String])

calculateWordProbabilities :: [Document] -> DocumentClass -> [(String, Double)]
calculateWordProbabilities documents category = 
    let categoryDocs = filter (\(docClass, _) -> docClass == category) documents
        categoryTokens = concatMap snd categoryDocs
        wordCounts = fromListWith (+) [(word, 1) | word <- categoryTokens]
        totalWords = length categoryTokens
    in [(word, fromIntegral count / fromIntegral totalWords) | (word, count) <- toList wordCounts]

calculateCategoryProbability :: [Document] -> DocumentClass -> Double
calculateCategoryProbability documents category =
    let totalDocs = length documents
        categoryDocs = length (filter (\(docClass, _) -> docClass == category) documents)
    in fromIntegral categoryDocs / fromIntegral totalDocs

classifyDocument :: [Document] -> [String] -> [(DocumentClass, Double)]
classifyDocument documents document =
    let categories = [Positive, Negative, Neutral]
        documentTokens = nub document
    in [(category, calculateCategoryProbability documents category * product [lookupWordProbability word category | word <- documentTokens]) | category <- categories]
    where
        lookupWordProbability word category = 
            case lookup word (calculateWordProbabilities documents category) of
                Just prob -> prob
                Nothing -> 1.0 / (fromIntegral (length (nub (map fst documents))) + 1.0)