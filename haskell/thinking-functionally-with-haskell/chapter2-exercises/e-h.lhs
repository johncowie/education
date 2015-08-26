Exercise E
----------

- define the following version of first

first :: (a -> Bool) -> [a] -> Maybe a

> first :: (a -> Bool) -> [a] -> Maybe a
> first p xs | null xs = Nothing
>            | p x = Just x
>            | otherwise = first p (tail xs)
>            where x = head xs 

Functions with type Maybe a -> Maybe a

=> We don't know anything about a, so the only thing that can be done
   is switching between none and the value (we can't create new ones).
   - Application to Nothing can only yield Nothing or undefined
   - Application to (Just x) can only yield (Just x), Nothing or undefined


Exercise F
----------

> expA :: Integer -> Integer -> Integer
> expA x n | n == 0 = 1
>          | n == 1 = x
>          | otherwise = x*expA x (n-1)

=> This takes (n-1) multiplications to evaluate expA x n

> expB :: Integer -> Integer -> Integer
> expB x n | n == 0 = 1
>          | n == 1 = x
>          | even n = expB (x*x) m
>          | odd n = x*expB (x*x) (m-1)
>          where m = div n 2

=> This takes log n multiplications


Exercise G
-----------

Suppose a date is represented by three integers (day, month, year).
Define 
	showDate :: Date -> String 
so that 
	showDate (10, 12, 2013) = "10th December, 2013"
	showDate (21, 11, 2020) = "21st November, 2020"

> type Date = (Int, Int, Int)
> showDate :: Date -> String
> showDate (d, m, y) = (showDay d) ++ " " ++ months !! (m-1) ++ ", " ++ (show y)

> showDay :: Int -> String
> showDay x | x == 1 || x == 21 || x == 31 = show x ++ "st"
> 	    | x == 2 || x == 22 = show x ++ "nd"
> 	    | x == 3 || x == 23 = show x ++ "rd"
> 	    | otherwise = show x ++ "th"

> months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"] 



Exercise H
-----------

CIN has final two digits which are sum of first eight digits.  Write a function
that takes eight digits and produces the final CIN

> type CIN = String
> addSum :: CIN -> CIN
> addSum cin = ((++) cin) . padNumber . show . sumString $ cin

> sumString = (foldl (+) 0) . (map getDigit)

> padNumber n = if (length n == 1) then "0" ++ n else n

> getDigit :: Char -> Int
> getDigit c = read [c]

Write a function that validates a CIN

> valid :: CIN -> Bool
> valid cin = length cin == 10 && sumString id == read checksum
>           where id       = take 8 cin
>                 checksum = drop 8 cin 
















       

