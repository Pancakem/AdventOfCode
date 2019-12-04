module Main where

import Day1 (part1, part2)
import Day2(parseInput, exec, calcNounVerb)

readLines :: FilePath -> IO [String]
readLines = fmap lines . readFile

main = do 
  putStrLn "DAY 1: \n"
  stringMasses <- readLines "input"
  let masses = map (\sm -> read sm :: Int) stringMasses 
  putStrLn ("Part 1: " ++  (show (part1 masses)))
  putStrLn ("Part 2: " ++ (show (part2 masses)))
  putStrLn "\nDAY 2: \n"
  line <- readFile "input2"
  let input = parseInput line
  let stat = exec input
  putStrLn ("Part 1: " ++ (show (head stat)))
  let nounVerb = calcNounVerb input
  putStrLn ("Part 2: " ++ (show nounVerb))


  
