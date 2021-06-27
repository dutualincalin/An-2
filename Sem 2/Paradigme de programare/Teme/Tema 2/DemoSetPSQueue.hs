{-
    import qualified ne forțează să utilizăm prefixul S. sau PQ. la referirea
    unei funcții din modulele respective. Acest lucru ne ajută să dezambiguizăm
    entitățile cu același nume din module diferite, ca, de exemplu,
    foldl standard pe liste, S.foldl, PQ.foldl.
-}
import qualified Data.Set as S
import qualified Data.PSQueue as PQ
import Data.Maybe (fromJust)

{-
    Set (mulțimi):

    Mulțimea vidă este S.empty.

    Evaluați în consolă:
    * someSet, și observați cum duplicatele sunt eliminate
    * S.insert 10 someSet
    * S.insert 2 someSet
    * S.member 2 someSet
    * S.member 10 someSet
-}
someSet :: S.Set Int
someSet = S.fromList [3,4,5,2,4,3]

{-
    Priority queues (cozi de priorități):
    * primul parametru de tip este tipul cheilor (Char)
    * al doilea parametru de tip este tipul priorităților (Int).

    Coada vidă este PQ.empty.

    Evaluați în consolă:
    * somePQ, și observați perechile cheie-prioritate
    * deleteFindMin somePQ
    * PQ.insertWith (+) 'a' 10 somePQ, și observați cum vechea cheie 'a',
        cu prioritate 1, este înlocuită cu o nouă cheie 'a', cu prioritate 11,
        obținută însumând vechea și noua prioritate
    * PQ.insertWith (+) 'c' 10 somePQ, și observați cum, în cazul unei chei
        absente inițial din coadă, insertWith se reduce la insert.
-}
somePQ :: PQ.PSQ Char Int
somePQ = PQ.insert 'a' 1 $ PQ.insert 'b' 2 $ PQ.empty

{-
    Funcție ce primește o coadă de priorități și întoarce o pereche
    formată din cheia cu prioritatea minimă și coada din care a fost ștearsă
    aceasta.
-}
deleteFindMin :: (Ord k, Ord p) => (PQ.PSQ k p) -> (k, (PQ.PSQ k p))
deleteFindMin pq = (minK, pq')
    where minK = PQ.key $ fromJust $ PQ.findMin pq
          pq' = PQ.deleteMin pq