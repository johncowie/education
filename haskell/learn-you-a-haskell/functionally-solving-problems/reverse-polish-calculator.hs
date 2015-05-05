-- Reverse Polish notation, push numbers onto the stack, 
-- if operation then pop two off the stack and apply operation,
--  and push result back onto the stack


solveRPN :: (Num a, Read a, Fractional a) => String -> a
solveRPN expression = head $ foldl processItem [] (words expression)

processItem :: (Num a, Read a, Fractional a) => [a] -> String -> [a]
processItem (h:h2:r) "+" = (h2 + h):r
processItem (h:h2:r) "/" = (h2 / h):r
processItem (h:h2:r) "*" = (h2 * h):r
processItem (h:h2:r) "-" = (h2 - h):r
processItem stack n = (read n):stack
