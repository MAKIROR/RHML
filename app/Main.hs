module Main (main) where

import TextCategorization

main :: IO ()
main = do
    let trainingData :: [(String, DocumentClass)]
        trainingData = [
            ("This is a good movie", Positive),
            ("The movie was terrible", Negative),
            ("An excellent film", Positive),
            ("I hated it, a really bad movie", Negative),
            ("It's an okay film", Neutral)
            ]