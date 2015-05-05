data LinkedList a = EmptyLinkedList | LinkedListElement a (LinkedList a) deriving (Show)

emptyLL :: LinkedList a
emptyLL = EmptyLinkedList

isLLEmpty :: LinkedList a -> Bool
isLLEmpty EmptyLinkedList = True
isLLEmpty _ = False

consLL :: a -> LinkedList a -> LinkedList a
consLL x l = LinkedListElement x l 

headLL :: LinkedList a -> a
headLL EmptyLinkedList = (error "Can't call head on an empty list")
headLL (LinkedListElement x _) = x 

tailLL :: LinkedList a -> LinkedList a
tailLL EmptyLinkedList = (error "Can't call tail on an empty list")
tailLL (LinkedListElement _ t) = t

concatLL :: LinkedList a -> LinkedList a -> LinkedList a
concatLL EmptyLinkedList l = l
concatLL xs ys = LinkedListElement (headLL xs) (concatLL (tailLL xs) ys)

mapLL :: (a -> b) -> LinkedList a -> LinkedList b
mapLL _ EmptyLinkedList = EmptyLinkedList
mapLL f (LinkedListElement x xs) = LinkedListElement (f x) (mapLL f xs)

asListLL :: LinkedList a -> [a]
asListLL EmptyLinkedList = []
asListLL (LinkedListElement x xs) = x:(asListLL xs)

updateLL :: LinkedList a -> Int -> a -> LinkedList a
updateLL EmptyLinkedList _ _ = (error "Index is out of bounds")
updateLL (LinkedListElement x xs) 0 v = LinkedListElement v xs
updateLL (LinkedListElement x xs) n v = LinkedListElement x (updateLL xs (pred n) v)

countLL :: LinkedList a -> Int
countLL EmptyLinkedList = 0
countLL (LinkedListElement x xs) = 1 + (countLL xs)

-------------------
-- exercise 2.1 -- write a function 'suffixes' such that suffixes [1, 2, 3, 4] = [[1, 2, 3, 4], [2, 3, 4], [3, 4], [4], []]
--		   demonstrate that it can be generated in O(n) time and O(n) space
-------------------

suffixes :: LinkedList a -> LinkedList (LinkedList a)
suffixes EmptyLinkedList = consLL EmptyLinkedList EmptyLinkedList 
suffixes list = consLL list (suffixes (tailLL list))

-- O(n) time because it just works through each element in the linked list once
-- O(n) space because each element in the new list is just a pointer to an existing element, so only cost is the length of the list which = n

suffixesAsLists :: LinkedList a -> [[a]]
suffixesAsLists l = (asListLL . (mapLL asListLL)) (suffixes l)

testList = foldr consLL emptyLL [1, 2, 3, 4, 5]

