-- Chapter 2 Problems

-- a) Write a sort that takes a list and returns a sorted list
insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) = if x < y then x:y:ys else y:(insert x ys)
insertionSort list = foldr insert [] list  

-- b) Write a sort that takes a list and comparator function and then sorts the list
compInsert :: (a -> a -> Bool) -> a -> [a] -> [a]
compInsert f x [] = [x]
compInsert f x (y:ys) = if (f x y) then x:y:ys else y:(compInsert f x ys)
compSort f list = foldr (compInsert f) [] list

-- c) Write a function that converts strings to numbers. Strings are in the form $2,234,345.99 and can have leading zeros

-- d) Write a function that takes x and returns a list that has every third number, starting with x. Ditto with every fifth number. 
--     Then combine these two functions together to return every eighth number.

everyNth :: (Num a) => a -> a -> [a]
everyNth n start = start:everyNth n (start + n)

everyThird = (everyNth 3)
everyFifth = (everyNth 5)
everyEighth x = zipWith (+) (everyThird x) (everyFifth x)

-- e) Use a partially applied function to define a function that halves numbers.
--     Then use another to define a function that appends \n to any string.

half = (/ 2)
returnStr = (++ "\n")

-- f) Write a function to determine the greatest common demoninator of two integers

greatestCommonDivisor :: Int -> Int -> Int
greatestCommonDivisor x y = last (filter (isCD x y) [1 .. (min x y)])
				where isCD x y d = mod x d == 0 && mod y d == 0
 
-- g) Create a lazy sequence of prime numbers
primes = filter isPrime [1..]
	  where isPrime 1 = False
		isPrime x = null (filter (\y -> mod x y == 0) [2 .. (x - 1)])  

-- h) Break a long string into individual lines at proper word boundaries
-- i) Add line numbers to the previous exercise
-- j) Add functions to left, right, and fully justify the text with spaces (both margins straight)



