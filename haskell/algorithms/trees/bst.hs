data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show, Read, Eq)

-- singleton makes a single-node tree
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

-- inserts an element into the tree
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node n left right) 
	| x == n = Node n left right
	| x < n = Node n (treeInsert x left) right
	| x > n = Node n left (treeInsert x right)

-- find min value in tree
treeMin :: Tree a -> Maybe a
treeMin EmptyTree = Nothing
treeMin (Node n EmptyTree _) = Just n
treeMin (Node n left right) = treeMin left

-- find max value in tree
treeMax :: Tree a -> Maybe a
treeMax EmptyTree = Nothing
treeMax (Node n _ EmptyTree) = Just n
treeMax (Node n left right) = treeMax right

-- delete a node from the tree
treeDelete :: (Ord a) => a -> Tree a -> Tree a
treeDelete x EmptyTree = EmptyTree
treeDelete x (Node n left right)
 	| x < n = Node n (treeDelete x left) right
 	| x > n = Node n left (treeDelete x right)
        | x == n = deleteNode (Node n left right) 
	where deleteNode (Node n EmptyTree EmptyTree) = EmptyTree
	      deleteNode (Node n left EmptyTree) = left
              deleteNode (Node n EmptyTree right) = right
              deleteNode (Node n left right) = Node rightMin left (treeDelete rightMin right)
		   where (Just rightMin) = treeMin right 

-- checks if an element is in the tree
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node n left right)
	| x == n = True
	| x < n = treeElem x left
	| x > n = treeElem x right

-- count elements in tree
treeCount :: Tree a -> Int
treeCount EmptyTree = 0
treeCount (Node n left right) = 1 + treeCount left + treeCount right

-- traverses the tree to produce a list
treeAsList :: Tree a -> [a]
treeAsList EmptyTree = []
treeAsList (Node n left right) = treeAsList left ++ [n] ++ treeAsList right

-- loads a list into the tree
treeFromList :: (Ord a) => [a] -> Tree a
treeFromList = foldr treeInsert EmptyTree 
