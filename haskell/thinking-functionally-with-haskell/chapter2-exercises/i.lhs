> import Data.Char (isAlpha, toLower)

Exercise I
-----------

Write an interactive program that tests palindromes.

> palindrome :: IO ()
> palindrome = do {putStrLn "Enter a string: ";
>		   candidate <- getLine;
>	           putStrLn $ if isPalindrome candidate then "Yes!" else "No!"
>		   }

> isPalindrome :: String -> Bool
> isPalindrome s = reverse prepared == prepared
> 	where prepared = (map toLower) . (filter isAlpha) $ s  
		
