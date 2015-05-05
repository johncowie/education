-- as well as destructing in pattern matching, can also use ':' to construct a list
--  e.g. 1:[2, 3] => [1, 2, 3]
--  lists are homogenuous so can't add list to list of integers
--    can add list to list of lists though
--    e.g. [1]:[[2], [3, 4]] => [[1], [2], [3, 4]]

-- all even numbers with list construction
allEven :: [Integer] -> [Integer]
allEven [] = []
allEven (h:t) = if even h then h:allEven t else allEven t


