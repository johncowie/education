-- RANGES
-- syntax for declaring a range: [x..y] (inclusive)
-- i.e. [1..2] => [1, 2]
-- other examples:
--   [10..4] => []
--   [10, 8 .. 4] => [10, 8, 6, 4]
--   [2, 1.5 .. 0] => [2, 1.5, 1, 0.5, 0]
--   [1 ..] => unbounded range from 1 onwards (i.e. a lazy sequence)

-- 'take'
-- take 5 [1 ..] => [1, 2, 3, 4, 5]

-- LIST COMPREHENSIONS

-- [x * 2 | x <- [1, 2, 3]] => [2, 4, 6]

-- Example: flipping polygon coordinates diagonally
-- [ (y, x) | (x, y) <- [(1, 2), (2, 3), (3, 1)]]
--     => [(2, 1), (3, 2), (1, 3)]

-- Example: flipping polygon coords horizontally
-- [ (4 - x, y) | (x, y) <- [(1, 2), (2, 3), (3, 1)]]
--    => [(3, 2), (2, 3), (1, 1)]

-- Combinations:
-- [ (x, y) | x <- [1, 2], y <- [1, 2]] => [(1, 1), (1, 2), (2, 1), (2, 2)]



