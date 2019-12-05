module Util (separateBy, readLines) where


import Data.List (unfoldr)

separateBy :: Eq a => a -> [a] -> [[a]]
separateBy chr = unfoldr sep where
    sep [] = Nothing
    sep l  = Just . fmap (drop 1) . break (== chr) $ l

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile