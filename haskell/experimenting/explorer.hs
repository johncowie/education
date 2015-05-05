import System.IO
import Control.Monad
import Text.Read

type Coord = (Int, Int)
type Surface = (Coord, Coord)
data Direction = N | E | S | W deriving (Show, Eq, Enum, Bounded, Read)
data Command = R | L | M deriving (Show, Eq, Read)
data Explorer = Explorer Surface Coord Direction deriving (Show)
data YesNo = Yes | No
data ExplorerError = ParseError | OutOfBoundsError

turnClockwise W = N
turnClockwise d = succ d

turnAntiClockwise N = W
turnAntiClockwise d = pred d

addCoords (x1, y1) (x2, y2) = (x1+x2, y1+y2)

coordTranslation :: Direction -> Coord
coordTranslation d = case d of
			N -> (0, 1)
			E -> (1, 0)
			S -> (0, -1)
			W -> (-1, 0)

isCoordOnSurface :: Surface -> Coord -> Bool
isCoordOnSurface ((sx1, sy1), (sx2, sy2)) (x, y) = not $ x < sx1 || x >= sx2 || y < sy1 || y >= sy2 

moveOnSurface :: Surface -> Coord -> Direction -> Coord
moveOnSurface surface coord dir = if (isCoordOnSurface surface newCoord) then newCoord else coord
					where newCoord = addCoords coord (coordTranslation dir)

executeCommand :: Explorer -> Command -> Explorer
executeCommand (Explorer surface coord dir) L = Explorer surface coord (turnAntiClockwise dir)
executeCommand (Explorer surface coord dir) R = Explorer surface coord (turnClockwise dir)
executeCommand (Explorer surface coord dir) M = Explorer surface (moveOnSurface surface coord dir) dir 

parseSurface :: String -> Either ExplorerError Surface
parseSurface string = case map readMaybe (words string) of
			[(Just x), (Just y)] -> Right ((0, 0), (x, y))
			_ -> Left ParseError

constructExplorer :: Surface -> Maybe Int -> Maybe Int -> Maybe Direction -> Either ExplorerError Explorer
constructExplorer surface (Just x) (Just y) (Just d) = if isCoordOnSurface surface (x, y) then Right (Explorer surface (x, y) d) else Left OutOfBoundsError
constructExplorer _ _ _ _ = Left ParseError

showExplorerPos :: Explorer -> String
showExplorerPos (Explorer _ (x, y) d) = (show x) ++ " " ++ (show y) ++ " " ++ (show d) 

parseExplorer :: Surface -> String -> Either ExplorerError Explorer
parseExplorer surface string = case words string of
				[x, y, d] -> constructExplorer surface (readMaybe x) (readMaybe y) (readMaybe d)
				_ -> Left ParseError

letters = map (\c -> c:[]) 

parseCommands :: String -> Either ExplorerError [Command]
parseCommands string = case sequence $ map readMaybe (letters string) of
			Just commands -> Right commands
			_ -> Left ParseError

parseYesNo :: String -> Either ExplorerError YesNo
parseYesNo "Y" = Right Yes
parseYesNo "N" = Right No
parseYesNo _ = Left ParseError

errorMessage :: ExplorerError -> String
errorMessage ParseError = "Invalid input. "
errorMessage OutOfBoundsError = "Explorer must start on surface. "

commandLineStage :: String -> (String -> Either ExplorerError a) -> (a -> IO ()) -> IO ()
commandLineStage prompt parseFn nextStage = do
	putStrLn prompt
	i <- getLine
	either (\e -> commandLineStage prompt parseFn nextStage) nextStage (parseFn i)

readSurface = commandLineStage "Enter coordinates for surface: " parseSurface readExplorer
readExplorer surface = commandLineStage "Enter start position and direction for explorer: " (parseExplorer surface) readCommands
readCommands explorer = commandLineStage "Enter commands for the explorer: " parseCommands (processCommands explorer)
readContinue surface = commandLineStage "Enter Y to add new rover or N to exit: " parseYesNo (processContinue surface)

surfaceFromExplorer (Explorer surface _ _) = surface

processCommands explorer commands = do
	foldM executeAndPrintCommand explorer commands
	readContinue $ surfaceFromExplorer explorer

executeAndPrintCommand explorer command = do
	putStrLn (showExplorerPos updatedExplorer)
	return updatedExplorer
	where updatedExplorer = (executeCommand explorer command)

processContinue surface Yes = readExplorer surface
processContinue surface No = terminate
	
terminate = do 
	return ()

main = readSurface
