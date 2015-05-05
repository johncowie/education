-- Insertion Sort
--  takes each element in a list and inserts them in the correct place in a new list

insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) = if x < y then x:y:ys else y:(insert x ys)
insertionSort list = foldr insert [] list

-- Selection Sort
--  finds the minimum value, puts it in the first position, and then does the same for the rest of the list

minIndex :: (Ord a) => Int -> Int -> [a] -> Int
minIndex mi ci [x] = mi
minIndex mi ci (x:y:ys) 
	| x < y = minIndex mi (succ ci) (x:ys)
	| otherwise = minIndex (succ ci) (succ ci) (y:ys)

swapByIndex :: (Ord a) => Int -> Int -> [a] -> [a]
swapByIndex i j ls = [get k x | (k, x) <- zip [0..] ls]
	where get k x | k == i    = ls !! j
		      | k == j    = ls !! i
		      | otherwise = x  

swapMinWithHead ls = (swapByIndex 0 (minIndex 0 0 ls) ls)

selectionSort [] = []
selectionSort [x] = [x]
selectionSort ls = x:selectionSort xs
	where (x:xs) = swapMinWithHead ls   

-- Bubble Sort
--  goes through the list sorting each pair to bubble the biggest to the top
--  then starts again, but goes until the last from the top .. etc...  until sorted

bubbleOne ls 0 = ls
bubbleOne (x:y:ys) i | x < y = x:bubbleOne (y:ys) (pred i) 
		     | otherwise = y:bubbleOne (x:ys) (pred i)
bubbleSort ls = foldl bubbleOne ls $ reverse [0..length ls - 1]

-- Shell Sort
-- Comb Sort

-- Merge Sort
--  merge two lists by taking the head of each, comparing sorting them and then adding the sorted pair two a new list
--  do this first with single element lists, then progressively bigger ones, until the list is sorted

mergeLists [] ys = ys
mergeLists xs [] = xs
mergeLists (x:xs) (y:ys) = if (x < y) then x:(mergeLists xs (y:ys)) else y:(mergeLists (x:xs) ys)

splitList l = (take halfLength l, drop halfLength l) 
 	where halfLength = quot (length l) 2

mergeSort [] = []
mergeSort [x] = [x] 
mergeSort l = mergeLists (mergeSort left) (mergeSort right)
	where (left, right) = splitList l

-- Heap Sort
-- Quick Sort
--  splits the list by an arbitary 'pivot' and moves values either side of the pivot, then applies to approach to each list of values either side of the pivot
quickSort [] = []
quickSort [x] = [x]
quickSort (x:xs) = (quickSort (filter (< x) xs)) ++ [x] ++ (quickSort (filter (>= x) xs)) 





