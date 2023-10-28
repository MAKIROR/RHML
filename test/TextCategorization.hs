import TextCategorization
import Data.Function (on)
import Data.List (maximumBy)

main :: IO ()
main = do
    let trainingData = [(Positive, ["love", "happy", "joy"]), (Negative, ["hate", "sad", "angry"]), (Neutral, ["neutral", "indifferent", "meh"])]
    let testSentence = words "I feel sad and angry"
    let classified = classifyDocument trainingData testSentence
    let result = maximumBy (compare `on` snd) classified
    putStrLn $ "The sentence belongs to class: " ++ show (fst result)