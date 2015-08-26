> import Data.Char (toUpper)

Exercise A
----------

'Is a half of two plus two equal to two or three?'

Yes! 

Could be either, dependending on precedence
i.e. (2 + 2) / 2 = 2
     2 + (2 / 2) = 3

Exercise B
---------- 

Which of the following expressions are well-formed?  
If they are well-formed give a suitable type.

a) [0, 1)  => N
b) double -3  => N - needs to be double (-3), otherwise it's trying to subtract 3 from the function double
c) double double 0  => N  - function application precedence from right to left, double double is invalid
d) if 1==0 then 2==1  => N  - no else clause
e) "++" == "+" ++ "+"  => Y  :: Bool
f) [(+),(-)]  =>  Y   :: (Num a) -> [a -> a -> a]  - can't be shown thow
g) [[],[[]],[[[]]]]  => Y!  - type is [[[[a]]]]
h) concat ["tea", "for", '2'] => N  - list contains different types
i) concat ["tea", "for", "2"] => Y  :: String

Exercise C
----------

1) What is uppercase version of toLower?  
   => toUpper

2) What does 
	unwords :: [Words] -> String
   do?
   => It joins words back together into one string, separated by spaces

3) Suppose a list has head x and tail xs - how would you reconstruct the list?
   => [x] ++ xs

Write a function moderise :: String -> String, that uppercases the first letter of all words in a string

> modernise :: String -> String
> modernise = unwords . map (\(x:xs) -> [toUpper x] ++ xs) .  words


Exercise D
----------

How many times would eager and lazy evaluation evaluate f in where xs is of length n?
  head (map f xs)?
  => eager: n times 
  => lazy: 1 time

What alternative would be better for eager evaluation?
  => (f . head) xs 

When filtering, why wouldn't eager evalution be good for head . filter p?  (p is a predicate)
  => Eager evaluation would have to test all elements, even though only one match is required

Complete the following definition:
  first :: (a -> Bool) -> [a] -> a
  first p xs | null xs   = error "Empty list"
             | p x       = ...
             | otherwise = ...
             where x = head xs

=>

> first :: (a -> Bool) -> [a] -> a
> first p xs | null xs   = error "Empty list"
>            | p x       = x
>            | otherwise = first p (tail xs)
>            where x = head xs   

What alternative might be better for eager evaluation to head . filter p . map f?
 => f . first (p . f)



