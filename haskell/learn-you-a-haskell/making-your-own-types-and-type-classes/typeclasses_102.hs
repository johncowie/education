-- Typeclasses are like interfaces that we can derive, e.g Show, Ord, Eq etc...

-- example of a hand-rolled derivation

data TrafficLight = Red | Yellow | Green

instance Eq TrafficLight where
	Red == Red = True
	Green == Green = True
	Yellow == Yellow = True
	_ == _ = False

instance Show TrafficLight where
	show Red = "Red light"
	show Green = "Green light"
	show Yellow = "Yellow light"


-- sometimes need to add class constraints i.e. in the below case when comparing equality of functors, their wrapped values need to be equatable

-- instance (Eq m) => Eq (Maybe m) where ...


-- A Yes/No type-class

class YesNo a where
	yesno :: a -> Bool
	
instance YesNo Int where
	yesno 0 = False
	yesno _ = True

instance YesNo [a] where
	yesno [] = False
	yesno _ = True

instance YesNo Bool where
	yesno = id   -- note id is the identity function

instance YesNo (Maybe a) where
	yesno (Just _) = True
	yesno Nothing = False

instance YesNo TrafficLight where
	yesno Red = False
	yesno _ = True


yesnoIf :: (YesNo y) => y -> a -> a -> a
yesnoIf yesNoVal yesResult noResult = if yesno yesNoVal then yesResult else noResult 


-- FUNctors

-- class Functor f where fmap :: (a -> b) -> f a -> f b

-- instance Functor [] where fmap = map

-- instance Functor Maybe where 
--    fmap f (Just x) = Just (f x)
--    fmap f Nothing = Nothing

-- e.g. fmap (+ 1) (Just 2) => (Just 3)
--      fmap (+ 1) Nothing => Nothing






