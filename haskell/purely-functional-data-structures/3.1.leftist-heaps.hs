-- is a binary tree in which the the rank of any left child is at least as large as the rank of its right sibling
--  rank is the length of its right spine (the rightmost path to an empty node)

data Heap a = E | T Int a (Heap a) (Heap a) deriving (Show)

emptyHeap :: Heap a
emptyHeap = E

isHeapEmpty :: Heap a -> Bool
isHeapEmpty E = True
isHeapEmpty _ = False

heapRank :: Heap a -> Int
heapRank E = 0
heapRank (T rank _ _ _) = rank

heapMerge :: (Ord a) => Heap a -> Heap a -> Heap a
heapMerge E h = h
heapMerge h E = h
heapMerge h1@(T r1 x1 a1 b1) h2@(T r2 x2 a2 b2)
	| x1 <= x2 = makeT x1 a1 (heapMerge b1 h2)
	| otherwise = makeT x2 a2 (heapMerge h1 b2)
	where makeT x a b 
		| (heapRank a) < (heapRank b) = T (heapRank a + 1) x b a
		| otherwise = T (heapRank b + 1) x a b

heapInsert :: (Ord a) => a -> Heap a -> Heap a
heapInsert x h = heapMerge (T 1 x E E) h 

findMin :: Heap a -> a
findMin E = error "No min in empty heap"
findMin (T _ x _ _) = x

deleteMin :: (Ord a) => Heap a -> Heap a
deleteMin E = error "No min in empty heap"
deleteMin (T _ x a b) = heapMerge a b

----------------
--Exercise 3.1--
----------------
-- Longest right spine (R) is when heap is a full, balanced tree
-- When this is the case then R is equal to the depth D of the tree.
-- n = 2^D - 1
-- ; D = log(n + 1) 
-- ; R = log(n + 1) when R is at it's maximum

----------------
--Exercise 3.2--
----------------
-- rewrite the insert function to not use 'merge'

heapInsert2 :: a -> Heap a -> Heap a
heapInsert2 x E = T 1 x E E
heapInsert2 x (T r y a b) = error "Unimplemented"



