---- Anonymous Functions
-- syntax (\param1 .. paramn -> function-body)

-- e.g. (\x -> x ++ " captain.") "Logical,"  => "Logical, captain."
-- e.g. map (\x -> x * x) [1, 2, 3, 4] => [1, 4, 9, 16]

squareAll list = map square list
 where square x = x * x

-- can use 'where' to bind data locally

incAll list = map (+ 1) list

-- can use partially applied functions (e.g. (+ 1))



---- Filter (same as clojure)
-- e.g. filter odd [1, 2, 3, 4, 5]

---- Folding (i.e. reduce)
-- fold takes a two arg function same as reduce

-- e.g. foldl (\x acc -> acc + x) 0 [1 .. 10] => 55

-- if you want to use an operator then can use foldl1
-- e.g. foldl (+) 0 [1 .. 3] => 6


