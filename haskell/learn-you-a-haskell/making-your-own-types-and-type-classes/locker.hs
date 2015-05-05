-- student want's a new locker, either the locker is free in which case the student gets a code, 
--  or it's taken in which case there'll be an error message

import qualified Data.Map as Map

data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Map.Map Int (LockerState, Code)

-- use either to represent hit (Code) or miss (error)
lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map = 
	case Map.lookup lockerNumber map of
	Nothing -> Left $ "Locker number " ++ show lockerNumber ++ " doesn't exist!"
	Just (state, code) -> if state /= Taken
				then Right code
				else Left $ "Locker " ++ show lockerNumber ++ " is already taken!"
lockers :: LockerMap
lockers = Map.fromList
	[(100, (Taken, "ABC"))
	,(101, (Free, "CDE"))
	,(102, (Free, "EFG"))
	,(103, (Free, "GHI"))
	,(104, (Taken, "IJK"))]

-- e.g. lockerLookup 101 lockers => Right "ABC"
