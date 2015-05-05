-- Can have synonyms for types
--  e.g. String is a synonym for [Char], they are equivalent and interchangable

-- making some types synonyms for a phonebook, to improve readability

type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)] 

-- function that determines if a name/number entry is in the book
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name, pnumber) `elem` pbook
