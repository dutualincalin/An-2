{-# LANGUAGE MultiParamTypeClasses #-}

module TestMTS where

import TestPP
import Basics
import Terrain
import ProblemState
import Search
import qualified Data.PSQueue as PQ
import Control.Arrow
import qualified Data.Set as S

newtype Tree = Tree { getTree :: Int } 
    deriving (Eq, Ord, Show)

instance ProblemState Tree Int where
    successors (Tree n)
        | n == 9    = [(1, (Tree 17)), (2, Tree 18)]
        | otherwise = [(1, Tree $ 2 * n + 1), (2, Tree $ 2 * n + 2)] ++ cycleLinks
        where
          cycleLinks = if n == 4 then [(3, Tree 0), (4, Tree 1)] else []

    isGoal (Tree n) = n == 18

    h (Tree n) = fromIntegral $ abs $ n - 18

testEmptyGame = do
    empGame1 <- readFile "tests/emptyGame1 - square board.txt"
    empGame2 <- readFile "tests/emptyGame2 - rectangular board.txt"
    return $ tests 1 3
        [ testVal "emptyGame1 - square board"
                  empGame1
                  $ show game1
        , testVal "emptyGame2 - rectangular board"
                  empGame2
                  $ show game2
        ]
    where
        game1 = emptyGame 3 3
        game2 = emptyGame 4 6

testAddHunter = do
    addHun1 <- readFile "tests/addHunter1 - initial position.txt"
    addHun2 <- readFile "tests/addHunter2 - board middle.txt"
    addHun3 <- readFile "tests/addHunter3 - right bottom corner.txt"
    addHun4 <- readFile "tests/addHunter4 - invalid position.txt"
    addHun5 <- readFile "tests/addHunter5 - position with obstacle.txt"
    return $ tests 2 2
        [ testVal "addHunter1 - initial position"
                  addHun1
                  $ show game1
        , testVal "addHunter2 - board middle"
                  addHun2
                  $ show game2
        , testVal "addHunter3 - right bottom corner"
                  addHun3
                  $ show game3
        , testVal "addHunter4 - invalid position"
                  addHun4
                  $ show game4
        , testVal "addHunter5 - position with obstacle"
                  addHun5
                  $ show game5
        ]
    where
        game1 = addHunter (1, 1) $ emptyGame 3 3
        game2 = addHunter (2, 2) $ emptyGame 5 5
        game3 = addHunter (2, 3) $ emptyGame 4 5
        game4 = addHunter (-1, -1) $ emptyGame 4 5
        game5 = addHunter (2, 0) $ emptyGame 5 5

testAddGateway = do
    addGate1 <- readFile "tests/addGateway1 - square board.txt"
    addGate2 <- readFile "tests/addGateway2 - rectangular board.txt"
    return $ tests 3 2
        [ testVal "addGateway1 - square board"
                  addGate1
                  $ show game1
        , testVal "addGateway2 - rectangular board"
                  addGate2
                  $ show game2
        ]
    where
        game1 = addGateway ((2, 1), (3, 4)) $ emptyGame 6 6
        game2 = addGateway ((5, 5), (4, 7)) $ addGateway ((3, 2), (1, 2)) $ emptyGame 7 9

testAddTarget = do
    addTar1 <- readFile "tests/addTarget1.txt"
    addTar2 <- readFile "tests/addTarget2.txt"
    return $ tests 4 2
        [ testVal "addTarget1"
                  addTar1
                  $ show game1
        , testVal "addTarget2"
                  addTar2
                  $ show game2
        ]
    where
        game1 = addTarget goEast (3, 4) $ emptyGame 6 6
        game2 = addTarget goNorth (3, 4) $ addTarget goSouth (1, 7) $ emptyGame 7 9

testAddObstacle = do
    addObs1 <- readFile "tests/addObstacle1.txt"
    addObs2 <- readFile "tests/addObstacle2.txt"
    return $ tests 5 2
        [ testVal "addObstacle1"
                  addObs1
                  $ show game1
        , testVal "addObstacle"
                  addObs2
                  $ show game2
        ]
    where
        game2 = addObstacle (2, 5) $ addObstacle (2, 4) $ addObstacle (2, 3) $ addObstacle (2, 2) $ addObstacle (2, 1) $ emptyGame 6 6
        game1 = addObstacle (3, 4) $ emptyGame 7 9

testGame1IO :: IO Game
testGame1IO = loadGame "terrains/terrain-1.txt" [goSouth, goNorth] [(0,1)]
testGame2IO :: IO Game
testGame2IO = loadGame "terrains/terrain-2.txt" [goEast, goWest] []
testGame3IO :: IO Game
testGame3IO = loadGame "terrains/terrain-3.txt" [goSouth] [(0,1), (2, 3)]
testGame4IO :: IO Game
testGame4IO = loadGame "terrains/terrain-4.txt" [bounce 1] [(0,1)]
testGame5IO :: IO Game
testGame5IO = loadGame "terrains/terrain-5.txt" [bounce 1, bounce 1] [(0,1)]
testGame6IO :: IO Game
testGame6IO = loadGame "terrains/terrain-6.txt" [bounce 1] [(0,1), (2, 4), (3, 5)]
testGame7IO :: IO Game
testGame7IO = loadGame "terrains/terrain-7.txt" [bounce 1, goEast, goEast] [(0,1)]

testAddAll :: IO TestData
testAddAll = do
    testGame1 <- testGame1IO
    testGame2 <- testGame2IO
    testGame3 <- testGame3IO
    testGame4 <- testGame4IO
    testGame5 <- testGame5IO
    testGame6 <- testGame6IO
    testGame7 <- testGame7IO
    addAll1 <- readFile "terrains/terrain-1.txt"
    addAll2 <- readFile "terrains/terrain-2.txt"
    addAll3 <- readFile "terrains/terrain-3.txt"
    addAll4 <- readFile "terrains/terrain-4.txt"
    addAll5 <- readFile "terrains/terrain-5.txt"
    addAll6 <- readFile "terrains/terrain-6.txt"
    addAll7 <- readFile "terrains/terrain-7.txt"
    return $ tests 6 7
        [ testVal "check add all elements 1"
                  addAll1
                  $ show testGame1
        , testVal "check add all elements 2"
                  addAll2
                  $ show testGame2
        , testVal "check add all elements 3"
                  addAll3
                  $ show testGame3
        , testVal "check add all elements 4"
                  addAll4
                  $ show testGame4
        , testVal "check add all elements 5"
                  addAll5
                  $ show testGame5
        , testVal "check add all elements 6"
                  addAll6
                  $ show testGame6
        , testVal "check add all elements 7"
                  addAll7
                  $ show testGame7
        ]

testAttemptMove :: IO TestData
testAttemptMove = do 
  testGame1 <- testGame1IO
  return $ tests 7 3
        [ testVal "check attemptMove 1: position is a free space"
                  (show $ Just pos1)
                  $ show $ attemptMove pos1 testGame1
        , testVal "check attemptMove 2: position is a gateway"
                  (show $ Just pos3)
                  $ show $ attemptMove pos2 testGame1
        , testVal "check attemptMove 3: position is a gateway"
                  (show $ Just pos2)
                  $ show $ attemptMove pos3 testGame1
        , testVal "check attempMove 4: position is an obstacle"
                  "Nothing"
                  $ show $ attemptMove pos4 testGame1
        ]
  where
    pos1 = (3, 1)
    pos2 = (1, 1)
    pos3 = (3, 4)
    pos4 = (0, 4)

testBehaviors :: IO TestData
testBehaviors = do
    testGame1 <- testGame1IO
    testGame2 <- testGame2IO
    testGame3 <- testGame3IO
    testGame4 <- testGame4IO
    testGame5 <- testGame5IO
    testGame6 <- testGame6IO
    testGame7 <- testGame7IO
    behavior1 <- readFile "tests/behaviors1.txt"
    behavior2 <- readFile "tests/behaviors2.txt"
    behavior3 <- readFile "tests/behaviors3.txt"
    behavior4 <- readFile "tests/behaviors4.txt"
    behavior5 <- readFile "tests/behaviors5.txt"
    behavior6 <- readFile "tests/behaviors6.txt"
    behavior7 <- readFile "tests/behaviors7.txt"
    return $ tests 8 8
        [ testVal "check behaviors 1: goSouth & goNorth"
                  behavior1
                  $ show $ moveTargets testGame1
        , testVal "check behaviors 2: goEast & goWest"
                  behavior2
                  $ show $ moveTargets $ moveTargets testGame2
        , testVal "check behaviors 3: gateways case"
                  behavior3
                  $ show $ moveTargets $ moveTargets $ moveTargets $ moveTargets testGame3
        , testVal "check behaviors 4: bounce"
                  behavior4
                  $ show $ moveTargets $ moveTargets $ moveTargets testGame4
        , testVal "check behaviors 5: bounce"
                  behavior5
                  $ show $ moveTargets $ moveTargets $ moveTargets $ moveTargets $ moveTargets testGame5
        , testVal "check behaviors 6: bounce"
                  behavior6
                  $ show $ moveTargets $ moveTargets $ moveTargets testGame6
        , testVal "check behaviors: bounce and gateways"
                  behavior7
                  $ show $ moveTargets $ moveTargets $ moveTargets $ moveTargets $ moveTargets $ moveTargets $ moveTargets testGame7
        ]

testIsTargetKilled :: IO TestData
testIsTargetKilled = return $ tests 9 3
        [ testVal "target is on the South cell"
                  "True"
                  $ show $ isTargetKilled (2, 2) tar1
        , testVal "target is on diagonal"
                  "False"
                  $ show $ isTargetKilled (2, 2) tar2
        , testVal "target is on the East cell"
                  "True"
                  $ show $ isTargetKilled (2, 2) tar3
        , testVal "target is far from the hunter"
                  "False"
                  $ show $ isTargetKilled (2, 2) tar4
        ]
    where
        tar1 = Target (3, 2) goSouth
        tar2 = Target (1, 1) goSouth
        tar3 = Target (2, 3) goSouth
        tar4 = Target (6, 7) goSouth

testAdvanceGame :: IO TestData
testAdvanceGame = do
    testGame1 <- testGame1IO
    testGame2 <- testGame2IO
    testGame3 <- testGame3IO
    testGame4 <- testGame4IO
    testGame5 <- testGame5IO
    testGame6 <- testGame6IO
    testGame7 <- testGame7IO
    advancegame1 <- readFile "tests/advancegame1.txt"
    advancegame2 <- readFile "tests/advancegame2.txt"
    advancegame3 <- readFile "tests/advancegame3.txt"
    advancegame4 <- readFile "tests/advancegame4.txt"
    advancegame5 <- readFile "tests/advancegame5.txt"
    advancegame6 <- readFile "tests/advancegame6.txt"
    advancegame7 <- readFile "tests/advancegame7.txt"
    return $ tests 10 8
        [ testVal "check advanceGame 1"
                  advancegame1
                  $ show $ advanceGameState West True testGame1
        , testVal "check advanceGame 2"
                  advancegame2
                  $ show $ advanceGameState South True $ advanceGameState South True $ advanceGameState South True $ advanceGameState South True testGame2
        , testVal "check advanceGame 3"
                  advancegame3
                  $ show $ advanceGameState South True $ advanceGameState South True $ advanceGameState South True testGame3
        , testVal "check advanceGame 4"
                  advancegame4
                  $ show $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True
                  $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True
                  $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True $ advanceGameState West True
                  $ advanceGameState South True $ advanceGameState South True $ advanceGameState South True testGame4
        , testVal "check advanceGame 5"
                  advancegame5
                  $ show $ advanceGameState East True $ advanceGameState East True $ advanceGameState East True $ advanceGameState East True $ advanceGameState North True
                  $ advanceGameState North True $ advanceGameState North True $ advanceGameState North True $ advanceGameState East True 
                  $ advanceGameState East True $ advanceGameState East True $ advanceGameState North True $ advanceGameState North True testGame5
        , testVal "check advanceGame 6"
                  advancegame6
                  $ show $ advanceGameState North False $ advanceGameState North False $ advanceGameState West False $ advanceGameState West False
                  $ advanceGameState South False $ advanceGameState South False $ advanceGameState East False $ advanceGameState East False $ advanceGameState East False
                  $ advanceGameState West False $ advanceGameState West False $ advanceGameState North False $ advanceGameState North False $ advanceGameState North False
                  $ advanceGameState North False $ advanceGameState East False $ advanceGameState East False testGame6
        , testVal "check advanceGame 7"
                  advancegame7
                  $ show $ advanceGameState North False $ advanceGameState North False $ advanceGameState West False $ advanceGameState West False $ advanceGameState South False testGame7
        ]

testSuccessors = do
    game <- loadGame "terrains/terrain-1.txt" [goNorth, goSouth] [(0, 1)]
    north <- readFile "tests/terrain-1-North.txt"
    south <- readFile "tests/terrain-1-South.txt"
    east <- readFile "tests/terrain-1-East.txt"
    west <- readFile "tests/terrain-1-West.txt"
    return $ test 10 5 $
        testSet "successors"
                (zip [North, South, East, West] [north, south, east, west])
                $ map (fmap show) $ successors game

testIsGoal = do
    north <- loadGame "tests/terrain-1-North.txt" [goNorth, goSouth] [(0, 1)]
    south <- loadGame "tests/terrain-1-South.txt" [goNorth, goSouth] [(0, 1)]
    return $ tests 11 5
        [ testCond "isGoal.True"
                   $ isGoal north
        , testCond "isGoal.False"
                   $ not $ isGoal south
        ]

testCreateStateSpaceTree = return $ tests 12 4.5
  [
    testSet "Tree.CreateStateSpace.State.Check" (map (getTree . nodeState) flattenNodes) [2, 5, 11, 23, 24, 12, 25, 26, 6, 13, 27, 28, 14, 29, 30],
    testSet "Tree.CreateStateSpace.Depth.Check" (map nodeDepth flattenNodes) [0, 1, 2, 3, 3, 2, 3, 3, 1, 2, 3, 3, 2, 3, 3],
    testSet "Tree.CreateStateSpace.Action.Check" (map nodeAction flattenNodes) [Nothing, Just 1, Just 1, Just 1, Just 2, Just 2, Just 1, Just 2, Just 2, Just 1, Just 1, Just 2, Just 2, Just 1, Just 2]
  ]
  where
    flattenNodes = flattenLvls 4 $ createStateSpace $ Tree 2

testSuitableSuccessors = return $ tests 13 4.5
  [
    testSet "SuitableSucc.Tree.OneChildVisited" (okSuccessors visited1) [ 4 ],
    testSet "SuitableSucc.Tree.NoVisitedChildren" (okSuccessors visited2) [ 3, 4 ]
  ]
  where
    n1 = createStateSpace (Tree 1)
    visited1 = S.singleton (Tree 3)
    visited2 = S.singleton (Tree 5)
    okSuccessors visited = map (getTree . nodeState) $ suitableSuccs n1 visited

testInsertSuccs = return $ tests 14 5
  [
    testSet "InsertSucc.Tree.Empty.PQ" (getKeysWithPrio res1) [(4, 14.0)],
    testSet "InsertSucc.Tree.NonEmpty.PQ.Smaller" (getKeysWithPrio res2) [(4, 14.0)],
    testSet "InsertSucc.Tree.NonEmpty.PQ.Bigger" (getKeysWithPrio res3) [(4, 1.0)],
    testSet "InsertSuccs.Tree.Empty.Set" (getKeysWithPrio res4) [(0, 19.0), (1, 18.0), (4, 20.0), (9, 10.0), (10, 9.0)],
    testSet "InsertSuccs.Tree.NonEmpty.Set" (getKeysWithPrio res5) [(0, 19.0), (9, 10.0)]
  ]
  where
    pq1 = PQ.insert node4 20 (PQ.singleton node1 30)
    pq2 = PQ.insert node9 20 (PQ.singleton node0 30)
    visit1 = S.empty
    visit2 = S.insert (Tree 1) $ S.singleton $ Tree 10
    node0 = createStateSpace $ Tree 0
    node1 = createStateSpace $ Tree 1
    node4 = createStateSpace $ Tree 4
    node9 = createStateSpace $ Tree 9
    res1 = PQ.toAscList $ insertSucc PQ.empty node4
    res2 = PQ.toAscList $ insertSucc (PQ.singleton node4 30) node4
    res3 = PQ.toAscList $ insertSucc (PQ.singleton node4 1) node4
    res4 = PQ.toAscList $ insertSuccs node4 pq1 visit1
    res5 = PQ.toAscList $ insertSuccs node4 pq2 visit2
    getKeysWithPrio = map ((getTree . nodeState . PQ.key) &&& PQ.prio)

testAStarTreeGoal = return $ tests 15 5
  [
    testVal "AStarGoal.Tree.Find18" (Tree 18) (nodeState n),
    testVal "AStarGoal.Tree.Depth" 4 (nodeDepth n)
  ]
  where
    n = astar $ createStateSpace (Tree 0)

testAStarTreePath = return $ tests 16 10
  [
    testVal "AStarPath.Tree.Root0" (evaluateTest 0) [1, 4, 9, 18],
    testVal "AStarPath.Tree.Root1" (evaluateTest 1) [4, 9, 18] ,
    testVal "AStarPath.Tree.Root3" (evaluateTest 4) [9, 18],
    testVal "AStarPath.Tree.Root8" (evaluateTest 9) [18],
    testVal "AStarPath.Tree.Goal"  (evaluateTest 18) [] 
  ]
  where
    evaluateTest n = map (getTree . snd) $ extractPath (astar $ createStateSpace (Tree n))

flattenLvls :: Int -> Node s a -> [Node s a]
flattenLvls d node
  | d == 0 = []
  | otherwise  = foldl (\acc x -> acc ++ (flattenLvls (d - 1) x)) [node] $ nodeChildren node

testSolveGame1IO :: IO Game
testSolveGame1IO = loadGame "terrains/game-1.txt" [goSouth] [(0,1)]
testSolveGame2IO :: IO Game
testSolveGame2IO = loadGame "terrains/game-2.txt" [goWest] []
testSolveGame3IO :: IO Game
testSolveGame3IO = loadGame "terrains/game-3.txt" [goSouth] [(0,1), (2, 3)]
testSolveGame4IO :: IO Game
testSolveGame4IO = loadGame "terrains/game-4.txt" [bounce 1] []
testSolveGame5IO :: IO Game
testSolveGame5IO = loadGame "terrains/game-5.txt" [bounce 1] [(0,1)]
testSolveGame6IO :: IO Game
testSolveGame6IO = loadGame "terrains/game-6.txt" [bounce 1] [(0,1)]
testSolveGame7IO :: IO Game
testSolveGame7IO = loadGame "terrains/game-7.txt" [bounce 1] [(0,1)]

testSolveGame = do
    testGame1 <- testSolveGame1IO
    testGame2 <- testSolveGame2IO
    testGame3 <- testSolveGame3IO
    testGame4 <- testSolveGame4IO
    testGame5 <- testSolveGame5IO
    testGame6 <- testSolveGame6IO
    testGame7 <- testSolveGame7IO
    return $ tests 17 21
        [
          testCond "Solve.Game.1" $ solveGame testGame1,
          testCond "Solve.Game.2" $ solveGame testGame2,
          testCond "Solve.Game.3" $ solveGame testGame3,
          testCond "Solve.Game.4" $ solveGame testGame4,
          testCond "Solve.Game.5" $ solveGame testGame5,
          testCond "Solve.Game.6" $ solveGame testGame6,
          testCond "Solve.Game.7" $ solveGame testGame7
        ]

testBonusGame = do
    testGame6 <- testSolveGame6IO
    return $ tests 18 10
        [
          testCond "Solve.Bonus.Game" $ bonusIsShorter testGame6
        ]
        where
          bonusIsShorter game = (lenBonusHeuristic game) < (lenEuclidean game)
          lenEuclidean game = length $ extractPath $ astar $ createStateSpace game
          lenBonusHeuristic game = length $ extractPath $ astar $ createStateSpace $ (BonusGame game)


solveGame :: Game-> Bool
solveGame game
  | not $ areTargetsLeft game = True
  | otherwise = solveGame game'
    where
      dir = (fst . head) $ extractPath $ astar $ createStateSpace game
      game' = advanceGameState dir True game

checkAll = vmCheckIO $ basics ++ problemState ++ search ++ bonus
    where
        basics       = [ testEmptyGame, testAddHunter, testAddGateway, testAddTarget, testAddObstacle, testAddAll, testAttemptMove, testBehaviors, testIsTargetKilled, testAdvanceGame]
        problemState = [ testSuccessors, testIsGoal ]
        search       = [ testCreateStateSpaceTree, testSuitableSuccessors, testInsertSuccs, testAStarTreeGoal, testAStarTreePath, testSolveGame ]
        bonus        = [ testBonusGame ]
