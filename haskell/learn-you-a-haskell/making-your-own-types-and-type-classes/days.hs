-- bounded implies that there is a lowest and highest possible value
 -- minBound :: Day    ;; => Sunday
 -- maxBoudn :: Day    ;; => Saturday 
-- part of the enum class because none of the value contructors take arguments (have fields)
 -- succ Monday   ;; => Tuesday
 -- pred Monday   ;; => Sunday
-- [minBound .. maxBound] :: [Day]  ;; => [Sunday, Monday, .. , Saturday]
-- can use range notation
 -- [Monday .. Thursday] => [Monday, Tuesday, Wednesday, Thursday]

data Day = Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday
	   deriving (Eq, Ord, Show, Read, Bounded, Enum)
