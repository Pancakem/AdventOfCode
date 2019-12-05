module Day3 (performInput) where

import Util (separateBy, readLines)
import Data.List
import Prelude hiding (Right, Left)

data Direction = 
    Right Int 
    | Left Int
    | Up Int
    | Down Int deriving(Show)

type Positions = [(Int, Int)]


separate :: String -> [String]
separate =
    separateBy ','

parseInput :: [[String]] -> [[Direction]]
parseInput =
    map $ map toDirection 

toDirection :: String -> Direction
toDirection str
    | head str == 'U' = Up (read $ tail str)
    | head str == 'R' = Right (read $ tail str)
    | head str == 'D' = Down (read $ tail str)
    | head str == 'L' = Left (read $ tail str)

traceWires :: [[Direction]] -> [Positions]
traceWires [] = []
traceWires dirs = 
    map (moving (0,0)) dirs

moving :: (Int, Int) -> [Direction] -> Positions
moving _ [] = []
moving pos dir =
    am ++ moving (last am) (tail dir)
    where
        am = move pos (toSteps (head dir)) (head dir)
    
same [] _ = []
same _ [] = []
same (x:xs) ys = if x `elem` ys
    then x:same xs (delete x ys)
    else same xs ys

findIntersection :: Positions -> Positions -> [(Int, Int)]
findIntersection pos1 pos2 = 
    same pos1 pos2
    
move :: (Int, Int) -> Int -> Direction -> Positions
move (x, y) steps dir = 
    handle (x,y) dir steps
    where 
        handle pos dir' x = if x < 1 then [pos] else smallMove pos dir' : handle (smallMove pos dir') dir' (x-1)

toSteps :: Direction -> Int
toSteps dir = case dir of
    Up steps ->
        steps
    Down steps ->
        steps
    Right steps ->
        steps
    Left steps ->
        steps

smallMove :: (Int, Int) -> Direction -> (Int, Int)
smallMove (x,y) (Up _) = (x, y+1)
smallMove (x,y) (Down _) = (x, y-1)
smallMove (x,y) (Left _) = (x-1, y)
smallMove (x,y) (Right _) = (x+1, y)

manhattan :: (Int, Int) -> Int
manhattan (x,y) = 
    abs x + abs y
     

performInput = do
    line <- readLines "input3"
    -- let line = ["R8,U5,L5,D3", "U7,R6,D4,L4"] 
    let dirs = (parseInput . map separate) line
    let (x:y:_) = traceWires dirs
    let d = findIntersection x y
    let manhattans = sort $ map manhattan d
    putStrLn (show (head manhattans))
    

