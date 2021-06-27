module Interactive where

import Basics
import Terrain
import ProblemState
import Search

{-
    Permite introducerea de la tastatură a direcției hunter-ului în fiecare pas,
    printr-una dintre literele:
    * w -> North
    * s -> South
    * d -> East
    * a -> West.

    Exemplu (vezi precizările din Terrain.hs):
    > interactive $ loadGame "terrains/terrain-1.txt" [goNorth, goSouth] [(0, 1)]
-}
interactive :: IO Game -> IO ()
interactive loader = loader >>= loop
  where
    loop :: Game -> IO ()
    loop game = do
        print game
        putStr "Choose hunter's move (w/a/s/d): "
        answer <- getLine
        let direction = case answer of
                            "w" -> Just North
                            "s" -> Just South
                            "d" -> Just East
                            "a" -> Just West
                            _   -> Nothing
        let newGame = case direction of
                          Just dir -> advanceGameState dir True game
                          _        -> game
        loop newGame

{-
    Aplică repetat A* pentru alegerea unei mutări a hunter-ului în scopul
    apropierii de un target (ales conform cu isGoal din ProblemState),
    până la capturarea tuturor target-urilor.

    Dacă primul parametru este True, se așteaptă apăsarea unei taste
    pentru continuarea simulării. Dacă este False, toți pașii sunt
    realizați deodată.

    Exemplu (vezi precizările din Terrain.hs):
    > hunt True $ loadGame "terrains/terrain-1.txt" [goNorth, goSouth] [(0, 1)]
-}    
hunt :: Bool -> IO Game -> IO ()
hunt stepwise loader = loader >>= loop 0
  where
    loop :: Int -> Game -> IO ()
    loop step game = do
        putStrLn $ "\nStep " ++ show step ++ ": "
        print game
        if areTargetsLeft game
            then do
                if stepwise then putStr "Press ENTER" >> getLine >> return () else return ()
                let initialNode = createStateSpace game
                let goalNode = astar initialNode
                let (direction, _) : _ = extractPath goalNode
                loop (step + 1) $ advanceGameState direction True game
            else
                putStrLn "\nNo targets left"

{-
    Similară cu hunt, dar folosită pentru bonusul Părții 2, pentru a lua în calcul
    instanța de ProblemState pentru BonusGame.
-}
bonusHunt :: Bool -> IO Game -> IO ()
bonusHunt stepwise loader = loader >>= loop 0
  where
    loop :: Int -> Game -> IO ()
    loop step game = do
        putStrLn $ "\nStep " ++ show step ++ ": "
        print game
        if areTargetsLeft game
            then do
                if stepwise then putStr "Press ENTER" >> getLine >> return () else return ()
                let initialNode = createStateSpace $ BonusGame game
                let goalNode = astar initialNode
                let (direction, _) : _ = extractPath goalNode
                loop (step + 1) $ advanceGameState direction True game
            else
                putStrLn "\nNo targets left"
