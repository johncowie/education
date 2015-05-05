---- Partially Applied Functions & Currying

-- e.g. prod is a function that takes an argument a that returns a function that takes a that when called returns a 

prod :: (Num a) => a -> a -> a
prod x y = x * y

-- can do map (prod 2) [1 .. 10] to multiply numbers by 2

---- Lazy Evaluation

-- can write a function that builds an infinite range

myRange start step = start:(myRange (start + step) step)

-- lazily evaluated version of fibonacci sequence

lazyFib :: (Num a) => a -> a -> [a]
lazyFib x y = x:(lazyFib y (x + y)) 
fib = lazyFib 1 1
fibNth x = head (drop (x - 1) (take (x) fib))

