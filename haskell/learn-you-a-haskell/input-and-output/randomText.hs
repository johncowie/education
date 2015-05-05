import System.IO

main = do
	handle <- openFile "random.txt" ReadMode
	contents <- hGetContents handle
	putStr contents
	hClose handle
