{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Search where

import ProblemState
import qualified Data.PSQueue as PQ
import Data.Maybe
import Prelude
import qualified Data.Set as S

{- 
Dutu Alin Calin
323CD
-}

{-
    Tipul unei nod utilizat în procesul de căutare. Recomandăm reținerea unor
    informații legate de:
    * stare;
    * acțiunea care a condus la această stare;
    * nodul părinte, prin explorarea căruia a fost obținut nodul curent;
    * adâncime;
    * estimarea costului până la starea finală;
    * copiii, ce vor desemna stările învecinate;
-}

data Node s a = Node{
    state :: s,
    action :: Maybe a,
    parent :: Maybe (Node s a),
    kids :: [Node s a],
    depth :: Int,
    estcost :: Float}

{-
    Instanțiați Eq și Ord pe baza stării.
-}

instance Eq s => Eq (Node s a) where
    node1 == node2 = nodeState node1 == nodeState node2

instance Ord s => Ord (Node s a) where
    node1 <= node2 = nodeState node1 <= nodeState node2

{-
    Gettere folosite pentru accesul la câmpurile nodului
-}

nodeState :: Node s a -> s
nodeState n = state n

nodeParent :: Node s a -> Maybe (Node s a)
nodeParent n = parent n

nodeDepth :: Node s a -> Int
nodeDepth n = depth n

nodeChildren :: Node s a -> [Node s a]
nodeChildren n = kids n

nodeHeuristic :: Node s a -> Float
nodeHeuristic n = estcost n

nodeAction :: Node s a -> Maybe a
nodeAction n = action n

{-
    Generarea întregului spațiu al stărilor.
    Primește starea inițială și creează nodul corespunzător acestei stări,
    având drept copii nodurile succesorilor stării curente, și așa mai
    departe, recursiv.
-}
createStateSpaceHelper :: (ProblemState s a, Eq s) => s -> Maybe a -> Maybe (Node s a) -> Int -> Float -> Node s a
createStateSpaceHelper s a p d e = currnode 
    where
        currnode = Node s a p [createStateSpaceHelper (snd status) (Just (fst status)) (Just currnode) (d + 1) (h (snd status)) | status <- successors s] d e

createStateSpace :: (ProblemState s a, Eq s) => s -> Node s a
createStateSpace iSt = createStateSpaceHelper iSt Nothing Nothing 0 (h iSt)

{-
    Funcție ce primește o coadă de priorități și întoarce o pereche
    formată din cheia cu prioritatea minimă și coada din care a fost ștearsă
    aceasta.
    Hint: O puteți folosi pentru a extrage și a șterge un nod din frontieră.
-}

deleteFindMin :: (Ord k, Ord p) => (PQ.PSQ k p) -> (k, (PQ.PSQ k p))
deleteFindMin pq = (minK, pq')
    where minK = PQ.key $ fromJust $ PQ.findMin pq
          pq' = PQ.deleteMin pq

{-
    Primește nodul curent și mulțimea stărilor vizitate și întoarce
    o listă cu nodurile succesor nevizitate, care ar putea fi introduse
    în frontieră.
-}

suitableSuccs :: (ProblemState s a, Ord s) => Node s a -> (S.Set s) -> [Node s a]
suitableSuccs node visited = [createStateSpaceHelper (snd status) (Just (fst status)) (Just node) ((nodeDepth node) + 1) (h (snd status)) | status <- filter (\succs -> (S.notMember (snd succs) (visited))) (successors (nodeState node))]

{-
    Primește o frontieră (o coadă de priorități) și un nod ce trebuie inserat în aceasta,
    întorcând o nouă frontieră.
    ATENȚIE: Dacă la introducerea unui nod există deja în frontieră un alt nod cu aceeași
    stare, dar cu cost mai mare, nodul nou, cu cost mai mic îl va înlocui pe cel vechi.
    
    Hints:
    1. Vedeți funcția insertWith din pachetul PSQueue.
        (https://hackage.haskell.org/package/PSQueue-1.1.0.1/docs/Data-PSQueue.html#v:insertWith)
    2. Costul se calculează ca suma dintre adâncime și euristică.
-}

insertSucc :: (ProblemState s a, Ord s) => (PQ.PSQ (Node s a) Float) -> Node s a -> PQ.PSQ (Node s a) Float
insertSucc frontier node = PQ.insertWith (\x y ->  case (x < y) of
        True -> x
        _ -> y)
        node ((fromIntegral (nodeDepth node)) + (nodeHeuristic node)) frontier

{-
    Primește nodul curent, frontiera și mulțimea stărilor vizitate, întorcând noua
    frontieră (coadă de priorități) în care au fost adăugate nodurile succesor validate
    de suitableSuccs.
-}

insertSuccs :: (ProblemState s a, Ord s) => (Node s a) -> (PQ.PSQ (Node s a) Float) -> (S.Set s) -> (PQ.PSQ (Node s a) Float)
insertSuccs node frontier visited = foldl (\front states -> insertSucc front states) frontier (suitableSuccs node visited)

{-
    Funcție helper care implementează A-star.
    Primește o mulțime de noduri vizitate și o coadă de priorități (aka frontiera) și
    întoarce starea finală.
    Se procedează astfel până la întâlnirea unei stări scop:
        - se extrage un nod adecvat din frontireră
        - se marchează starea acestuia ca fiind vizitată
        - se introduc succesorii în frontieră
-}

astar' :: (ProblemState s a, Ord s) => (S.Set s) -> (PQ.PSQ (Node s a) Float) -> Node s a
astar' visited frontier
    | (nodeHeuristic (fst minPair)) == 0 = fst minPair
    | otherwise = case succs of 
        [] -> astar' visited (snd minPair)
        _ -> astar' (S.insert (nodeState (fst minPair)) visited) (insertSuccs (fst minPair) (snd minPair) visited)
    where
        minPair = deleteFindMin frontier 
        succs = suitableSuccs (fst minPair) visited

{-
    Primește starea inițială și întoarce starea finală pentru o singură aplicare
    a algoritmului.
    Asigură parametrii inițiali corecți pentru aplicarea funcției astar'.
-}

astar :: (ProblemState s a, Ord s) => Node s a -> Node s a
astar initialNode = astar' (S.empty) (PQ.singleton initialNode ((fromIntegral (nodeDepth initialNode)) + (nodeHeuristic initialNode)))

{-
    Pornind de la un nod, reface parțial calea către nodul inițial, urmând legăturile
    către părinți.
    Întoarce o listă de perechi (acțiune, stare), care pornește de la starea următoare
    stării inițiale și se încheie la starea finală.
    ATENȚIE: Nodul inițial este singurul exclus!
-}

getAction :: Maybe a -> a
getAction = head.maybeToList

extractPath :: Node s a -> [(a, s)]
extractPath goalNode = reverse [( getAction (nodeAction node), nodeState node) | node <- lista]
    where
    lista = take (nodeDepth goalNode) (iterate (\x -> fromMaybe goalNode (nodeParent x)) goalNode)