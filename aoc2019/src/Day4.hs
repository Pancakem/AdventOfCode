module Day4 (day4) where

import Data.List

makeRange :: [Int]
makeRange = 
    [136760..595730]

testAdjaceny :: String -> Bool
testAdjaceny (x:y:xs) = (x == y) || testAdjaceny (y:xs)
testAdjaceny _ = False

checkDecrease :: String -> Bool
checkDecrease (x:y:xs) = (x <= y) && checkDecrease (y:xs)
checkDecrease _ = True

testAdjacentDouble :: String -> Bool
testAdjacentDouble num = 
    any (\digit -> length digit == 2) $ group num   

doTest :: Int -> Bool
doTest num = testAdjaceny pass && checkDecrease pass
    where pass = show num


doTest2 :: Int -> Bool
doTest2 num = doTest num && testAdjacentDouble pass
    where pass = show num

day4 = do
    putStrLn "Part 1:"
    putStrLn (show $ length (filter doTest makeRange))
    putStrLn "Part 2:"
    putStrLn (show $ length (filter doTest2 makeRange))