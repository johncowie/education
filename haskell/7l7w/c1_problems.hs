-- a) How many different ways can you find to write allEven?

-- b) Write a function that takes a list and returns the same list in reverse
myReverse :: [a] -> [a]
myReverse [] = []
myReverse [a] = [a]
myReverse (x:xs) = myReverse xs ++ [x]

-- c) Return all possible combinations of two colours of black, white, blue, yellow, red  (NB (blue, black) = (black, blue))
colours = ["black", "white", "blue", "yellow", "red"]
colourCombinations :: [a] -> [(a, a)]
colourCombinations [] = []
colourCombinations [a] = []
colourCombinations [a, b] = [(a, b)]
colourCombinations (x:xs) = [(x, b) | b <- xs] ++ colourCombinations xs

-- d) Write a list comprehension to produce a multiplication table,  should be a list of three-tuples (x, y, product)
timesTables = [(x, y, x * y) | x <- [1..12], y <- [1..12]]

-- e) Solve the map colouring problem


