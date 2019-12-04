module Day1 (part1, part2) where


computeFuel :: Int -> Int
computeFuel mass =
    (mass `div` 3) - 2


moduleFuel :: Int -> Int
moduleFuel mass
    | computeFuel mass <= 0 = 0
    | otherwise = computeFuel mass + moduleFuel (computeFuel mass)

fuelForMass :: Int -> Int
fuelForMass = flip (-) 2 . (`div` 3)
    
accFuelForMass :: Int -> Int
accFuelForMass =
    sum . takeWhile (> 0) . drop 1 . iterate fuelForMass
    
part1 :: [Int] -> Int
part1 = sum . map computeFuel
    
part2 :: [Int] -> Int
part2 = sum . map moduleFuel

