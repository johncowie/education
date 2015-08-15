> import Data.Char (toLower, toUpper)

Exercise A
----------

Given a function:

> double :: Integer -> Integer
> double x = 2*x

What are the values of the following expressions:

map double [1, 4, 4, 3]  => [2, 8, 8, 6]
map (double . double) [1, 4, 4, 3]  =>  [4, 16, 16, 12]
map double []  => []
 
Sum is a function that sums a list of integers

> sum :: [Integer] -> Integer
> sum = foldl (+) 0

Which of the following are true?

sum . map double = double . sum  
  => true - doubling all the numbers and then summing them is the same as summing the total
sum . map sum = sum . concat  
  => true - sum some lists and then adding them together, is the same as joining the lists and finding the sum of that larger list
sum . sort = sum 
  => true - sorting the numbers first won't affect their total



Exercise B
-----------

Which of the following expressions is a rendering of sin²Θ into Haskell?

a) sin^2 theta
b) sin theta^2
c) (sin theta)^2

Answer: c

How would you express sin2Θ/2Π ?

 => sin (2*theta) / (2*pi)


Exercise C
----------

What are the types of 'H' and "H"?

 => 'H' is a Char and "H" is a [Char] (i.e. String)

What is the difference between 2001 and "2001"?

 => 2001 is an Integer, "2001" is a String

What do the following produce?

[1, 2, 3] ++ [3, 2, 1]
 => [1, 2, 3, 3, 2, 1]
"Hello " ++ " World!"
 => "Hello World!"
[1, 2, 3] ++ []
 => [1, 2, 3]
"Hello" ++ "" ++ "World!
 => "HelloWorld!"


Exercise D
----------

Get a list of words, and then convert them all to lowercase
	
> lowerWords = map (map toLower) . words


Exercise E
----------

Which of the following are associative?

  Numerical addition:  Y    => (1 + 2) + 3 = 1 + (2 + 3)
  List concatenation:  Y    => ("1" ++ "2") ++ "3" = "1" ++ ("2" ++ "3") 
  Function composition: Y  => (f . g) . h = f . (g . h)
  
Give an example of a number operator that isn't associative

  => Subtraction   (1 - 2) - 3 /= 1 - (2 - 3)

What are the identity elements of the following?

 Addition: 0
 Concatenation: []
 Function composition: id


Exercise F
----------

Define the sub-functions required to make a function anagrams, that takes a number n and a list of words, and arranges the n length words into an anagram dictionary string

anagrams :: Int -> [Word] -> String

anagrams n = concat . formatGroups . groupByLabel . sortByLabels . (map sortLetters) . (filter (isLength? n))


Exercise G
----------

Write a function 'song', that produces the words to the song 'One man went to mow' for n men. Assume n < 10

> song :: Int -> String
> song n = if n==0 then ""
>          else song (n-1) ++ "\n" ++ verse n

> verse n = line1 n ++ line2 n ++ line3 n ++ line4 n
> line1 n = startWithUpper (people n ++ " went to mow\n")
> line2 n = "Went to mow a meadow\n"
> line3lower  n = if n==1 then "one man and his dog\n"
>                 else (people n) ++ ", " ++ line3lower (n-1)
> line3 = startWithUpper . line3lower 
> line4 = line2

> startWithUpper (x:xs) = ((toUpper x):xs)  
> people n = if n > 1 then numbers!!n ++ " men" else numbers!!n ++ " man"
> numbers = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]








