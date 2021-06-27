{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE EmptyDataDecls, MultiParamTypeClasses,
             TypeSynonymInstances, FlexibleInstances,
             InstanceSigs #-}

{- 
Dutu Alin Calin
323CD
-}

module Basics where
{-
    Expune funcțiile necesare reprezentării jocului.
-}

import ProblemState

{-
    Sinonim tip de date pentru reprezetarea unei perechi (Int, Int)
    care va reține coordonatele celulelor de pe tabla de joc.
    Colțul stânga-sus este (0, 0).
-}
type Position = (Int, Int)

{-
    Tip de date pentru reprezentarea Target-urilor.
    Acestea conțin informații atât despre poziția curentă a
    Target-ului cât și despre comportamentul acestuia.
    Tipul Behavior este definit mai jos.
-}
data Target = Target {
    position :: Position,
    behavior :: Behavior
}

instance Eq Target where
    Target p1 _ == Target p2 _ = p1 == p2

instance Ord Target where
    Target p1 _ <= Target p2 _ = p1 <= p2

{-
    Tip de date pentru reprezentarea comportamentului unui Target.
    Tipul Behavior este utilizat pentru a modela tranziția Target-urilor
    din starea curentă în starea următoare. Primul parametru este poziția
    actuală a target-ului, iar al doilea, starea curentă a jocului.
    Tipul Game este definit mai jos.
    
    Observați că, din moment ce un Behavior produce un Target nou,
    acesta din urmă ar putea fi caracterizat de un alt Behavior
    decât cel anterior.
-}
type Behavior = Position -> Game -> Target

{-
    Direcțiile de deplasare pe tablă
-}
data Direction = North | South | West | East
    deriving (Eq, Show)

{-
    Tip de date pentru reprezentarea stării jocului, la un anumit
    moment. Completați-l cu orice informație aveți nevoie pentru
    stocarea stării jocului (hunter, target, obstacole, gateways).
-}

data Hunter = Hunter {
    posH :: Position}

instance Eq Hunter where
    Hunter p1 == Hunter p2 = p1 == p2

instance Ord Hunter where
    Hunter p1 <= Hunter p2 = p1 <= p2
{-------------------------------------}

data Gateway = Gateway{
    posG :: Position,
    pairPos :: Position}

instance Eq Gateway where
    Gateway p1 _ == Gateway p2 _ = p1 == p2

instance Ord Gateway where
    Gateway p1 _ <= Gateway p2 _ = p1 <= p2

{-------------------------------------}

data Barrier = Barrier{
    posB :: Position}

instance Eq Barrier where
    Barrier p1 == Barrier p2 = p1 == p2

instance Ord Barrier where
    Barrier p1 <= Barrier p2 = p1 <= p2

{-------------------------------------}

data Game = Game
    { no_lines :: Int
    , no_columns :: Int
    , targets :: [Target]
    , hunter :: Hunter
    , gateways :: [Gateway]
    , barriers :: [Barrier]
    } deriving (Eq, Ord)


{-
    *** Optional *** 
  
    Dacă aveți nevoie de o funcționalitate particulară,
    instantiați explicit clasele Eq și Ord pentru Game.
    În cazul acesta, eliminați deriving (Eq, Ord) din Game.
-}

{-
    Reprezentați starea jocului ca șir de caractere, pentru afișarea
    la consolă.
    
    Atenție! Fiecare linie, mai puțin ultima, este urmată de \n.
    Celule goale vor fi reprezentate ca ' '.
    Hunter-ul va fi reprezentat ca '!'.
    Target-urile vor fi reprezentate ca '*'
    Gateways-urile vor fi reprezentate ca '#'.
    Obstacolele vor fi reprezentate de '@'.

    Hint: S-ar putea să vă fie utile list comprehensions,
    precum și funcțiile elem, any și intercalate din Data.List.
-}

showObj :: Position -> Game -> Char
showObj pos g
    | any (\l -> pos == position l) (targets g) = '*'
    | pos == (posH (hunter g)) = '!'
    | any (\l -> pos == posG l) (gateways g) = '#'
    | any (\l -> pos == posB l) (barriers g) = '@'
    | otherwise = ' '


gameAsString :: Game -> String
gameAsString g = (concat [[showObj (x, y) g | y <- [0..((no_columns g) - 1)]] ++ ['\n'] | x <- [0..((no_lines g) - 2)]]) ++ [showObj ((no_lines g) - 1, y) g | y <- [0..((no_columns g) - 1)]]

instance Show Game where
    show = gameAsString


{-
    Primește numărul de linii și numărul de coloane ale tablei de joc.
    Intoarce un obiect de tip Game în care tabla conține spații goale în interior, fiind
    împrejmuită de obstacole pe toate laturile. Implicit, colțul din stânga sus este (0,0),
    iar Hunterul se găsește pe poziția (1, 1).
-}
emptyGame :: Int -> Int -> Game
emptyGame x y = Game x y [] (Hunter (1, 1)) [] [Barrier (a, b) | a <- [0..(x - 1)], b <- [0..(y - 1)], a == 0 || b == 0 || a == x - 1 || b == y - 1] 

{-
    Primește o poziție și un joc și întoarce un nou joc, cu Hunter-ul pus
    pe poziția specificată.
    Parametrul Position reprezintă poziția de pe hartă la care va fi adaugat Hunter-ul
    Daca poziția este invalidă (ocupată sau în afara tablei de joc) se va întoarce
    același joc.
-}
addHunter :: Position -> Game -> Game
addHunter pos@(l, c) g
    | l >= (no_lines g) || (l < 0) || c >= (no_columns g) || c < 0 = g
    | showObj pos g /= ' ' = g
    | any (\ob -> pos == posB ob) (barriers g) = g
    | otherwise = Game (no_lines g) (no_columns g) (targets g) (Hunter pos) (gateways g) (barriers g)

{-
    Primește un comportament, o poziție și un joc și întoarce un nou joc, în care a fost
    adăugat Target-ul descris de comportament și poziție.
    Parametrul Behavior reprezintă comportamentul Target-ului care va fi adăugat.
    Parametrul Position reprezintă poziția de pe hartă la care va fi adăugat Target-ul.
-}
addTarget :: Behavior -> Position -> Game -> Game
addTarget b pos@(l, c) g
    | l >= (no_lines g) || (l < 0) || c >= (no_columns g) || c < 0 = g
    | any (\ob -> pos == posB ob) (barriers g) = g
    | otherwise = Game (no_lines g) (no_columns g) ((Target pos b) : targets g) (hunter g) (gateways g) (barriers g)

{-
    Primește o pereche de poziții și un joc și întoarce un nou joc, în care au fost adăugate
    cele două gateway-uri interconectate.
    Parametrul (Position, Position) reprezintă pozițiile de pe hartă la care vor fi adăugate 
    cele două gateway-uri interconectate printr-un canal bidirecțional.
-}
addGateway :: (Position, Position) -> Game -> Game
addGateway (pos1@(l1, c1), pos2@(l2, c2)) g
    | l1 >= (no_lines g) || (l1 < 0) || c1 >= (no_columns g) || c1 < 0 || l2 >= (no_lines g) || (l2 < 0) || c2 >= (no_columns g) || c2 < 0 = g
    | any (\ob -> pos1 == posB ob || pos2 == posB ob) (barriers g) = g 
    | otherwise = Game (no_lines g) (no_columns g) (targets g) (hunter g) ([(Gateway pos1 pos2)] ++ [(Gateway pos2 pos1)] ++ gateways g) (barriers g)


{-
    Primește o poziție și un joc și întoarce un nou joc, în care a fost adăugat un obstacol
    la poziția specificată.
    Parametrul Position reprezintă poziția de pe hartă la care va fi adăugat obstacolul.
-}
addObstacle :: Position -> Game -> Game
addObstacle pos@(l, c) g
    | l >= (no_lines g) || (l < 0) || c >= (no_columns g) || c < 0 = g
    | otherwise = Game (no_lines g) (no_columns g) (targets g) (hunter g) (gateways g) ((Barrier pos) : barriers g)

{-
    Primește o poziție destinație înspre care vrea să se deplaseze o entitate (Hunter sau Target)
    și verifică daca deplasarea este posibilă, întorcând noua poziție, luând în considerare
    și Gateway-urile.
    Avem următoarele cazuri:
    - dacă poziția corespunde unui spațiu gol, se întoarce acea poziție;
    - dacă poziția corespunde unui gateway, se întoarce poziția gateway-ului pereche;
    - dacă poziția corespunde unui obstacol, se întoarce Nothing.
    Parametrul Position reprezintă poziția destinație.
-}

getGatewayPair :: Position -> Game -> Maybe Position
getGatewayPair pos g
    | any (\l -> pos == posG l) (gateways g) =  Just(pairPos (head (filter (\l -> pos == posG l) (gateways g))))
    | otherwise = Nothing

attemptMove :: Position -> Game -> Maybe Position
attemptMove pos g 
    | (showObj pos g) == ' ' = Just pos
    | any (\l -> pos == posG l) (gateways g) = (getGatewayPair pos g)
    | any (\l -> pos == posB l) (barriers g) = Nothing
    | otherwise = Just pos

{-
    Comportamentul unui Target de a se deplasa cu o casuță înspre est. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
    
    Conform definiției, tipul Behavior corespunde tipului funcție
    Position -> Game -> Target.
    
    Având în vedere că cele patru funcții definite în continuare (goEast, goWest,
    goNorth, goSouth) sunt foarte similare, încercați să implementați o funcție
    mai generală, pe baza căreia să le definiți apoi pe acestea patru.
-}

nothingCaseBehavior :: Position -> Game -> Behavior -> Target
nothingCaseBehavior pos g b = case attemptMove pos g of
    Just a -> Target a b
    Nothing -> Target pos b


goEast :: Behavior
goEast (x, y) g = case attemptMove (x, (y + 1)) g of
    Just a -> Target a goEast
    Nothing -> nothingCaseBehavior (x, y) g goEast

{-
    Comportamentul unui Target de a se deplasa cu o casuță înspre vest. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
-}
goWest :: Behavior
goWest (x, y) g = case attemptMove (x, (y - 1)) g of
    Just a -> Target a goWest
    Nothing -> nothingCaseBehavior (x, y) g goWest

{-
    Comportamentul unui Target de a se deplasa cu o casuță înspre nord. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
-}
goNorth :: Behavior
goNorth (x, y) g = case attemptMove ((x - 1), y) g of
    Just a -> Target a goNorth
    Nothing -> nothingCaseBehavior (x, y) g goNorth

{-
    Comportamentul unui Target de a se deplasa cu o casuță înspre sud. 
    Miscarea se poate face doar daca poziția este validă (se află pe tabla de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul va rămâne 
    pe loc.
-}
goSouth :: Behavior
goSouth (x, y) g = case attemptMove ((x + 1), y) g of
    Just a -> Target a goSouth
    Nothing -> nothingCaseBehavior (x, y) g goSouth

{-
    Comportamentul unui Target de a-și oscila mișcarea, când înspre nord, când înspre sud. 
    Mișcarea se poate face doar dacă poziția este validă (se află pe tablă de
    joc) și nu este ocupată de un obstacol. In caz contrar, Target-ul iși va schimba
    direcția de mers astfel:
    - daca mergea inspre nord, își va modifica direcția miscării înspre sud;
    - daca mergea inspre sud, își va continua mișcarea înspre nord.
    Daca Target-ul întâlneste un Gateway pe traseul său, va trece prin acesta,
    către Gateway-ul pereche conectat și își va continua mișcarea în același sens la ieșire
    din acesta.
    Puteți folosit parametrul Int pentru a surprinde deplasamentul Target-ului (de exemplu,
    1 pentru sud, -1 pentru nord).
-}
bounce :: Int -> Behavior
bounce num (x, y) g
    |num == 8 = case attemptMove ((x - 1), y) g of
        Just a -> Target a (bounce 8)
        Nothing -> case attemptMove ((x + 1), y) g of
            Just a -> Target a (bounce 2)
            Nothing -> Target (x, y) (bounce 2)
    |otherwise = case attemptMove ((x + 1), y) g of
        Just a -> Target a (bounce 2)
        Nothing -> case attemptMove ((x - 1), y) g of
            Just a -> Target a (bounce 8)
            Nothing -> Target (x, y) (bounce 8)

{-
    Funcție care mută toate Target-urile din Game-ul dat o poziție, în functie
    de behavior-ul fiecăreia și întoarce noul Game în care pozițiile Target-urilor
    sunt actualizate.
    
-}

moveTargets :: Game -> Game
moveTargets g = Game (no_lines g) (no_columns g) [(behavior t) (position t) g| t <- (targets g)] (hunter g) (gateways g) (barriers g)

{-
    Verifică dacă Targetul va fi eliminat de Hunter.
    Un Target este eliminat de Hunter daca se află pe o poziție adiacentă
    cu acesta.
    Parametrul Position reprezintă poziția Hunterului pe tabla
    de joc.
    Parametrul Target reprezintă Targetul pentru care se face verificarea.
-}
isTargetKilled :: Position -> Target -> Bool
isTargetKilled (x, y) t
    | (x + 1, y) == (position t) = True
    | (x - 1, y) == (position t) = True
    | (x, y + 1) == (position t) = True
    | (x, y - 1) == (position t) = True
    | otherwise = False


{-
    Avansează starea jocului curent, rezultând starea următoare a jocului.
    Parametrul Direction reprezintă direcția în care se va deplasa Hunter-ul.
    Parametrul Bool specifică dacă, după mutarea Hunter-ului, vor fi
    mutate și Target-urile sau nu, și dacă vor fi eliminate din joc sau nu.
    Este folosit pentru a distinge între desfășurarea reală a jocului (True)
    și planificarea „imaginată” de hunter (False) în partea a doua a temei.

    Avansarea stării jocului respectă următoarea ordine:
    1. Se deplasează Hunter-ul.
    2. În funcție de parametrul Bool, se elimină Target-urile omorâte de către Hunter.
    3. In funcție de parametrul Bool, se deplasează Target-urile rămase pe tablă.
    4. Se elimină Targeturile omorâte de către Hunter și după deplasarea acestora.
    
    Dubla verificare a anihilării Target-urilor, în pașii 2 și 4, îi oferă Hunter-ului
    un avantaj în prinderea lor.
-}

removeKilledTargets :: Game -> Game
removeKilledTargets g = Game (no_lines g) (no_columns g) (filter (\t -> (isTargetKilled (posH (hunter g)) t) == False) (targets g)) (hunter g) (gateways g) (barriers g)

hunterMove :: Position -> Position -> Game -> Game
hunterMove inpos pos g = case (attemptMove pos g) of
    Just a -> Game (no_lines g) (no_columns g) (targets g) (Hunter a) (gateways g) (barriers g)
    Nothing -> case attemptMove inpos g of
        Just a -> Game (no_lines g) (no_columns g) (targets g) (Hunter a) (gateways g) (barriers g)
        Nothing -> g

advanceGameState :: Direction -> Bool -> Game -> Game
advanceGameState way bool_val g
    | bool_val = case way of
        North -> removeKilledTargets (moveTargets (removeKilledTargets (hunterMove (posH (hunter g)) ((fst (posH (hunter g))) - 1 , snd (posH (hunter g))) g)))
        South -> removeKilledTargets (moveTargets (removeKilledTargets (hunterMove (posH (hunter g)) ((fst (posH (hunter g))) + 1 , snd (posH (hunter g))) g)))
        East -> removeKilledTargets (moveTargets (removeKilledTargets (hunterMove (posH (hunter g)) (fst (posH (hunter g)), (snd (posH (hunter g))) + 1) g)))
        West -> removeKilledTargets (moveTargets (removeKilledTargets (hunterMove (posH (hunter g)) (fst (posH (hunter g)), (snd (posH (hunter g))) - 1) g)))
    | otherwise = case way of
        North -> hunterMove (posH (hunter g)) ((fst (posH (hunter g))) - 1 , snd (posH (hunter g))) g
        South -> hunterMove (posH (hunter g)) ((fst (posH (hunter g))) + 1 , snd (posH (hunter g))) g
        East -> hunterMove (posH (hunter g)) (fst (posH (hunter g)), (snd (posH (hunter g))) + 1) g
        West -> hunterMove (posH (hunter g)) (fst (posH (hunter g)), (snd (posH (hunter g))) - 1) g


{-  
    Verifică dacă mai există Target-uri pe table de joc.
-}

areTargetsLeft :: Game -> Bool
areTargetsLeft g = null (targets g)

{-
    *** BONUS TODO ***

    Comportamentul unui Target de a se deplasa în cerc, în jurul unui Position, având
    o rază fixată.
    Primul parametru, Position, reprezintă centrul cercului.
    Parametrul Int reprezintă raza cercului.
    Puteți testa utilizând terenul circle.txt din directorul terrains, în conjuncție
    cu funcția interactive.
-}
circle :: Position -> Int -> Behavior
circle = undefined


instance ProblemState Game Direction where
    {-
        Generează succesorii stării curente a jocului.
        Utilizați advanceGameState, cu parametrul Bool ales corespunzător.
    -}
    successors g = [(North, advanceGameState North False g), (South, advanceGameState South False g), (East, advanceGameState East False g), (West, advanceGameState West False g)]

    {-
        Verifică dacă starea curentă este una în care Hunter-ul poate anihila
        un Target. Puteți alege Target-ul cum doriți, în prezența mai multora.
    -}
    isGoal g = any (\t -> (isTargetKilled (posH (hunter g)) t)) (targets g)

    {-
        Euristica euclidiană (vezi hEuclidian mai jos) până la Target-ul ales
        de isGoal.
    -}
    h g = case isGoal g of
        True -> hEuclidean (posH (hunter g)) (position (head (filter (\t -> (isTargetKilled (posH (hunter g)) t)) (targets g))))
        False -> hEuclidean (posH (hunter g)) (position (head (targets g)))

{-
     ** NU MODIFICATI **
-}
hEuclidean :: Position -> Position -> Float
hEuclidean (x1, y1) (x2, y2) = fromIntegral $ ((x1 - x2) ^ pow) + ((y1 - y2) ^ pow)
  where
    pow = 2 :: Int

{-
    *** BONUS ***

    Acesta reprezintă un artificiu necesar pentru testarea bonusului,
    deoarece nu pot exista două instanțe diferite ale aceleiași clase
    pentru același tip.

    OBSERVAȚIE: Testarea bonusului pentru Seach este făcută separat.
-}

newtype BonusGame = BonusGame Game
    deriving (Eq, Ord, Show)

{-
    *** BONUS TODO ***

    Folosind wrapper-ul peste tipul Game de mai sus instanțiați
    ProblemState astfel încât să fie folosită noua euristică. 
-}
instance ProblemState BonusGame Direction where
    {-
        *** BONUS TODO ***

        Pentru a ne asigura că toțî succesorii unei stări sunt de tipul
        BonusGame și folosesc noua euristică trebuie să aplicăm wrapper-ul
        definit mai sus peste toți succesorii unei stări.

        Hint: Puteți să folosiți funcția fmap pe perechi pentru acest lucru.
        https://wiki.haskell.org/Functor
    -}
    successors = undefined

    {-
        *** BONUS TODO ***

        Definiți funcția isGoal pentru BonusGame.

        Hint: Folosiți funcția isGoal deja implementată pentru tipul Game.
    -}
    isGoal = undefined

    {-
        *** BONUS TODO ***

        Definiți o funcție euristică care este capabilă să găsească un drum mai scurt
        comparativ cu cel găsit de euristica implementată pentru Game.

        ATENȚIE: Noua euristică NU trebuie să fie una trivială.

        OBSERVAȚIE: Pentru testare se va folosi fișierul terrains/game-6.txt.
    -}
    h = undefined
