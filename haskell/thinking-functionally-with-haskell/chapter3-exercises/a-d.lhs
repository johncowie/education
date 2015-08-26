Exercise A
-----------

Which of the following expressions denote 1?

-2 + 3 => 1
3 + -2 => err
3 + (-2) => 1
subtract 2 3 => 1
2 + subtract 3 => err

Express subtract using flip

> mysubtract = flip (-)

Exercise B
-----------

Exponentiation functions:

(^)  :: (Num a, Integral b) => a -> a -> a
(^^) :: (Fractional a, Integral b) => a -> b -> a
(**) :: (Floating a) => a -> a -> a


How would you define (^^)?

nb my version of ^^ is /\

> (/\) :: (Fractional a, Integral b) => a -> b -> a
> (/\) x n = if n >= 0 then x^n else 1/x ^ (negate n)


Exercise C
----------

Could you define div in the following way?

div :: Integral a => a -> a -> a
div x y = floor (x/y)

No - you would need to call fromInteger on x and y

> myDiv :: Integral a => a -> a -> a
> myDiv x y = floor (fromIntegral x / fromIntegral y)


Exercise D
-----------

Consider this version of floor:

floor :: Float -> Integer
floor = read . (takeWhile (/= '.') . show)

Why won't it work?

- Haskell will show very large numbers like this 3.34E10 - this wouldn't work because 3 would be returned instead of the nearby very large number
- Haskell will show some numbers like this 3.34E-7 - it wouldn't work for these very small numbers
- Wouldn't work for negative numbers (e.g. -3.5 , floored should be -4 not -3)










 
               


