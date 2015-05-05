data Person = Person { firstName :: String
		     , lastName :: String
		     , age :: Int 
		     , height :: Float
		     , phoneNumber :: String
		     , flavor :: String
		     } deriving (Show)

-- the above syntax allows you to create accessors for the types in the type constructor
-- can also use the above to construct with map syntax e.g. Person { firstName="John", lastName="Doe" etc..}
-- note that when constructing a Person this way, all the values are required but don't have to be specified in the same order

