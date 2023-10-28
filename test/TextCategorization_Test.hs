import Lib
import Data.Function (on)
import Data.List (maximumBy)

main :: IO ()
main = do
    let trainingData = [(Positive, ["love", "happy", "joy"]), (Negative, ["hate", "sad", "angry"]), (Neutral, ["neutral", "indifferent", "meh"])]
    let testSentence = words "I feel sad and angry"
    let documents = concatMap (\(category, tokens) -> [(category, tokens) | _ <- [1 :: Int .. 10 :: Int]]) trainingData
    let classified = classifyDocument documents testSentence
    let result = maximumBy (compare `on` snd) classified
    putStrLn $ "The sentence belongs to class: " ++ show (fst result)