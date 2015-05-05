
-- The Hofstadter Figure-Figure sequence is defined as below, where R(n) is the nth number in the sequence, 
--  and S(n) is the nth number not present in the sequence
-- R(1) = 1
-- S(1) = 2
-- R(n) = R(n-1) + S(n-1) 

-- hofReq :: Int -> [Int] -> [Int]
figFigR r [] = r:(figFigR (r+s) [r+2 .. r+s-1])
		where s = r+1
figFigR r (s:ss) = r:(figFigR (r+s) (ss ++ [r+1 .. r+s-1]))

-- figFig returns a lazy-sequence of numbers in the Hofstadter Figure-Figure sequence
figFig = figFigR 1 []

-- figFigNth returns the nth number in the Figure-Figure sequence
figFigNth n = last $ take n figFig


-- Usage
--  take 10 figFig = [1, 3, 7, 12, 18, 26, 35, 45, 56, 69] 
 
  
-- G sequence
-- G(0) = 0
-- G(n) = n - G(G(n-1))

g 0 = 0
g n = n - g(g(n-1))

-- H sequence
-- H(0) = 0
-- H(n) = n - H(H(H(n-1)))
h 0 = 0
h n = n - h(h(h(n-1)))
