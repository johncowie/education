
-- deriving Eq gives us equality checking for free
-- read can construct a Person from a string
-- i.e. read (show (Person "a" "b" 1)) :: Person


data Person = Person {firstname :: String, lastname :: String, age :: Int} deriving (Eq, Show, Read)
