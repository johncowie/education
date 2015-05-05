----------------------
---- Functor Laws ----

-- a) fmap id f = f
-- b) fmap (f . g) = (fmap f) . (fmap g)


-- example - CounterMaybe
data CMaybe a = CNothing | CJust Int a deriving (Show)

instance Functor CMaybe where
	fmap f CNothing = CNothing
	fmap f (CJust counter x) = CJust (counter + 1) (f x)

-- fmap id (CJust 0 "a") = CJust 1 "a" => doesn't obey first functor law




