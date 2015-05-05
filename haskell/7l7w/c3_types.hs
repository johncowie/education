---- Types

-- can define our own types with the 'data' keyword
-- e.g. data Boolean = True False

-- (see c3_cards.hs for cards type)


---- Polymorphic Types

data Triplet a = Trio a a a deriving (Show)

-- Trio is the data constructor


---- Recursive Types

data Tree a = Children [Tree a] | Leaf a deriving (Show)

-- let leaf = Leaf 1
-- let (Leaf value) = leaf
-- value   => 1

-- let tree = Children[Leaf 1, Children[Leaf 2, Leaf 3]) etc..

depth (Leaf _) = 1
depth (Children c) = 1 + maximum (map depth c)



---- Classes

-- a Type is an instance of a class if it has an implementation for all of the class functions


 
