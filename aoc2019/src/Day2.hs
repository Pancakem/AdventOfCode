module Day2 (parseInput, exec, calcNounVerb) where

import Data.List (unfoldr)

type Destination = Int
type Source = Int

type Memory = [Int]

data Instruction = 
    Add Source Source Destination
    | Multiply Source Source Destination
    | Halt deriving (Show)

separateBy :: Eq a => a -> [a] -> [[a]]
separateBy chr = unfoldr sep where
  sep [] = Nothing
  sep l  = Just . fmap (drop 1) . break (== chr) $ l


replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth n newVal (x:xs)
  | n == 0 = newVal:xs
  | otherwise = x:replaceNth (n-1) newVal xs

-- accessElement :: Int -> [Int] -> Int
-- accessElement indx program = 
--   program !! indx

-- # this won't work unless the changes are put onto the structure the program state continues to change

-- -- executeInstruction returns a index, value pair we will use to build an array of the final program
-- executeInstruction :: Int -> [Int] -> [(Int, Int)]
-- executeInstruction opcodeIndex program
--   | accessElement opcodeIndex program == 1 = (accessElement (opcodeIndex + 3) program, (accessElement (opcodeIndex + 1) program) + (accessElement (opcodeIndex + 2) program)) : executeInstruction (opcodeIndex + 4) program
--   | accessElement opcodeIndex program == 2 = (accessElement (opcodeIndex + 3) program, (accessElement (opcodeIndex + 1) program) * (accessElement (opcodeIndex + 2) program)) : executeInstruction (opcodeIndex + 4) program
--   | accessElement opcodeIndex program == 99 = [(opcodeIndex, 99)]


parseInput :: String -> Memory
parseInput =
  ( replaceNth 1 12 . replaceNth  2 2 ) . map read . separateBy ','


executeInstruction :: Instruction -> Memory -> Memory
executeInstruction (Add s1 s2 d1) memory = replaceNth d1 ((memory !! s1) + (memory !! s2)) memory
executeInstruction (Multiply s1 s2 d1) memory = replaceNth d1 ((memory !! s1) * (memory !! s2)) memory

getInstruction :: Int -> Memory -> Instruction
getInstruction index mem = opcode $ mem !! index
  where 
    opcode 1 = Add source1 source2 dest 
    opcode 2 = Multiply source1 source2 dest
    opcode 99 = Halt
    source1 = mem !! (index + 1)
    source2 = mem !! (index + 2)
    dest = mem !! (index + 3)

exec :: Memory -> Memory
exec program = 
    exec' 0 program
    where 
      exec' indx mem = exec'' (getInstruction indx mem)
        where
          exec'' Halt = mem
          exec'' instruction = exec' (indx + 4) (executeInstruction instruction mem)          

replaceNounVerb :: Memory -> (Int, Int) -> Memory
replaceNounVerb memory (noun, verb) = ((replaceNth 1 noun) . (replaceNth 2 verb)) memory

genPrograms :: Memory -> [Memory]
genPrograms memory = 
  map (replaceNounVerb memory) [(noun, verb) | noun <- [0..99], verb <- [0..99]]

execPrograms :: Memory -> [Memory]
execPrograms memory = 
  map exec $ genPrograms memory
  
findTarget :: Memory -> Int -> Memory
findTarget memory target = 
  (filter (\mem -> mem !! 0 == target ) $ execPrograms memory) !! 0

calcNounVerb :: Memory -> Int
calcNounVerb memory = 
  100 * (mem !! 1) + (mem !! 2)
    where 
      mem = findTarget memory 19690720