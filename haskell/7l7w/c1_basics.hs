module Main where 
	double :: Integer -> Integer
	double x = x + x

	factorial :: Integer -> Integer
	factorial 0 = 1
	factorial x = x * factorial (x - 1)

	-- factorial using a guard
	factorial2 :: Integer -> Integer
	factorial2 x
		| x > 1 = x * factorial (x - 1)
		| otherwise = 1

	-- raise an integer to the power of another using guards
	pow :: Integer -> Integer -> Integer
	pow n x
		| x > 0 = n * pow n (x - 1)
		| otherwise = 1

	-- quicksort
	qsort :: (Ord a) => [a] -> [a]
	qsort [] = []
	qsort [x] = [x]
	qsort (x:xs) = qsort (filter (< x) xs) ++ [x] ++ qsort (filter (>= x) xs)

	-- fibonacci with simple recursion
	fibr :: Integer -> Integer
	fibr 0 = 1
	fibr 1 = 1
	fibr n = fibr (n - 1) + fibr (n - 2)	

	-- fibonacci using tuples
	fibt :: (Integer, Integer, Integer) -> (Integer, Integer, Integer)
	fibt (x, y, 0) = (x, y, 0)
	fibt (x, y, i) = fibt (y, y + x, i - 1)
	fibResult :: (Integer, Integer, Integer) -> Integer
	fibResult (x, y, z) = x
	fib :: Integer -> Integer
	fib x = fibResult (fibt (0, 1, x))

	-- functional composition (i.e. chaining functions together)
	second :: [a] -> a
	second = head . tail

	-- fibonacci using functional composition 
	fibNextPair :: (Integer, Integer) -> (Integer, Integer)
	fibNextPair (x, y) = (y, x + y)
	
	fibNthPair :: Integer -> (Integer, Integer)
	fibNthPair 1 = (1, 1)	
	fibNthPair n = fibNextPair (fibNthPair (n - 1))

	fibp :: Integer -> Integer
	fibp = fst . fibNthPair 

	-- 'let' binding with pattern matching
	-- let (h:t) = [1, 2, 3, 4]
	-- h => 1   t => [2, 3, 4]

	-- size function with recursion
	size [] = 0
	size (h:t) = 1 + size t
	prod [] = 1
	prod (h:t) = h * prod t

	-- 'zip' zips two lists into a list of tuples
	-- e.g. zip ['a', 'b', 'c'] [1, 2, 3] => [('a', 1), ('b', 2), ('c', 3)]



	 
