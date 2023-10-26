module TextCategorization (classifyDocument, DocumentClass) where

import Data.Map (Map, fromListWith, toList)
import Data.List (sort)
import Data.Char (toLower)
import Data.Maybe (fromMaybe)

data DocumentClass = Positive | Negative | Neutral deriving (Eq, Show)

vocabulary :: [String]
vocabulary = ["good", "bad", "excellent", "poor", "amazing", "terrible"]

tokenize :: String -> [String]
tokenize = map (map toLower) . words

wordFrequencies :: [String] -> Map String Int
wordFrequencies = fromListWith (+) . flip zip (repeat 1)

trainClassifier :: [(String, DocumentClass)] -> Map DocumentClass (Map String Int)
trainClassifier trainingSet = fromListWith (unionFrequencies) [
    (cls, wordFrequencies (tokenize doc))
    | (doc, cls) <- trainingSet
    ]

unionFrequencies :: Map String Int -> Map String Int -> Map String Int
unionFrequencies = fromListWith (+) . toList

classifyDocument :: Map DocumentClass (Map String Int) -> String -> DocumentClass
classifyDocument classFrequencies document =
    argmax (\cls -> calculateClassProbability cls (tokenize document)) [Positive, Negative, Neutral]
  where
    argmax _ [] = error "No classes provided"
    argmax f (x:xs) = foldr (\y acc -> if f y > f acc then y else acc) x xs

    calculateClassProbability cls docWords =
        let classWordFreq = fromMaybe (fromList []) (lookup cls classFrequencies)
            totalWords = sum (elems classWordFreq)
            wordProb word = fromIntegral (findWordFrequency word classWordFreq + 1) / fromIntegral (totalWords + length vocabulary)
            findWordFrequency word freqMap = fromMaybe 0 (lookup word freqMap)
        in product (map wordProb docWords)