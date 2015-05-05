data Tree a = E | T (Tree a) a (Tree a) deriving (Show)

emptyTree :: Tree a
emptyTree = E

isEmptyTree :: Tree a -> Bool
isEmptyTree E = True
isEmptyTree _ = False

treeMember :: (Ord a) => a -> Tree a -> Bool
treeMember _ E = False
treeMember v (T l x r)
	| v < x = treeMember v l
	| v > x = treeMember v r
	| otherwise = True

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x E = T E x E
treeInsert x (T l y r)
	| x > y = T l y (treeInsert x r)
	| x < y = T (treeInsert x l) y r
	| otherwise = T l y r

treeInsertAll :: (Ord a) => Tree a -> [a] -> Tree a
treeInsertAll tree list = foldr treeInsert tree list
	
treeFromList :: (Ord a) => [a] -> Tree a
treeFromList = (treeInsertAll emptyTree)

treeAsList :: Tree a -> [a]
treeAsList E = []
treeAsList (T left x right) = (treeAsList left) ++ [x] ++ (treeAsList right) 

countTree :: Tree a -> Int
countTree E = 0
countTree (T l x r) = 1 + (countTree l) + (countTree r)

-- Exercise 2.2
-- worst case of treeMember performs 2d comparisons
-- write a version that performs d+1 comparisons in worst case

betterMember :: (Ord a) => a -> Tree a -> Bool
betterMember _ E = False
betterMember v (T l x y) = betterMemberR v (T l x y) x

betterMemberR :: (Ord a) => a -> Tree a -> a -> Bool
betterMemberR v E candidate = v == candidate
betterMemberR v (T l x r) candidate 
	| v <= x = betterMemberR v l x
	| otherwise = betterMemberR v r candidate

-- Exercise 2.3
-- If element exists, then insert can end up copying tree unnecessarily
-- write a version that errors if element already exists
treeInsert2 :: (Ord a) => a -> Tree a -> Tree a
treeInsert2 x E = T E x E
treeInsert2 x (T l y r)
	| x > y = T l y (treeInsert2 x r)
	| x < y = T (treeInsert2 x l) y r
	| otherwise = error "Element already exists"

-- Exercise 2.4
-- Write another version of the insert above that performs the insert with no more than d+1 comparisons
treeInsert3 :: (Ord a) => a -> Tree a -> Tree a
treeInsert3 x E = T E x E
treeInsert3 x (T l y r) = treeInsert3' x (T l y r) y

treeInsert3' :: (Ord a) => a -> Tree a -> a -> Tree a
treeInsert3' v E candidate
	| v == candidate = error "Element already exists"
	| otherwise = (T E v E)
treeInsert3' v (T l x r) candidate 
	| v <= x = T (treeInsert3' v l x) xr
	| otherwise = T l x (treeInsert3' v r candidate)

-- Exercise 2.5
--  a) Write a function 'complete' which takes an element and a depth and creates a complete tree with the element at every node
complete :: a -> Int -> Tree a
complete x 0 = emptyTree
complete x n = T sub x sub
	where sub = complete x (pred n) 

--  b) Extend function to create trees of arbitary size of elements, the difference in size between two sub-trees should be no more than one
--     hint/ create a function create2, which creates a pair of trees of size m and m+1

balanced :: a -> Int -> Tree a
balanced x n 
	| n <= 0 = E
	| odd n = T subL x subL
	| otherwise = T subL x subR
	where subL = balanced x leftSize
	      subR = balanced x (leftSize - 1)
	      leftSize = quot n 2

-- Exercise 2.6 
-- create a map implementation using the tree functor

type TreeMap k v = Tree (k, v)

emptyTreeMap :: TreeMap a b
emptyTreeMap = E

treeMapInsert :: (Ord k) => k -> v -> (TreeMap k v) => (TreeMap k v)
treeMapInsert k v E = T E (k, v) E
treeMapInsert k v (T l (ek, ev) r)
		| k > ek = T l (ek, ev) (treeMapInsert k v r)
		| k < ek = T (treeMapInsert k v l) (ek, ev) r
		| otherwise = T l (k, v) r   

treeMapLookup :: (Ord k) => k -> (TreeMap k v) -> v
treeMapLookup _ E = (error "Key not found")
treeMapLookup k (T l (ek, ev) r) 
		| k > ek = treeMapLookup k r
		| k < ek = treeMapLookup k l
		| otherwise = ev

treeMapFromList :: (Ord k) => [(k, v)] -> (TreeMap k v)
treeMapFromList = foldr (\(k, v) t -> treeMapInsert k v t) emptyTreeMap




 






