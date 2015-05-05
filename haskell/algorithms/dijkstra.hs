import qualified Data.Map as Map
import Control.Applicative

-- TODO
-- Make addEdge a bit nicer

type Graph a = Map.Map a (Map.Map a Int)
type Edge a = (a, Int, a)
data Path a = NoPath | Path [a] Int deriving (Eq, Show)

emptyGraph = Map.empty

addEdge :: (Ord a) => Edge a -> Graph a -> Graph a
addEdge (start, weight, end) graph = addNode end $ Map.alter addEdgeWeight start graph
	where addEdgeWeight Nothing = Just (Map.singleton end weight)
	      addEdgeWeight (Just m) = Just (Map.insert end weight m)
	      addNode n m = if (Map.member n m) then m else (Map.insert n Map.empty m)

hasVertex :: (Ord a) => a -> Graph a -> Bool
hasVertex v graph = Map.member v graph

deleteVertex :: (Ord a) => a -> Graph a -> Graph a
deleteVertex v graph = Map.delete v graph

getEdge :: (Ord a) => a -> a -> Graph a -> Maybe (Edge a)
getEdge a b graph = Map.lookup a graph >>= (Map.lookup b) >>= (\w -> Just (a, w, b))
	       
getEdges :: (Ord a) => a -> Graph a -> [Maybe (Edge a)]
getEdges a graph = (maybe [] id) maybeEdges
	where maybeEdges = (map (\b -> getEdge a b graph)) <$> Map.keys <$> Map.lookup a graph	

edgeAsPath Nothing = NoPath
edgeAsPath (Just (start, weight, end)) = Path [start, end] weight

areDirectlyConnected :: (Ord a) => a -> a -> Graph a -> Bool
areDirectlyConnected a b graph = Nothing /= getEdge a b graph 

addEdges :: (Ord a) => [Edge a] -> Graph a -> Graph a 
addEdges edges graph = foldr addEdge graph edges

initGraph edges = addEdges edges emptyGraph

combinePaths :: (Eq a) => Path a -> Path a -> Path a
combinePaths NoPath _ = NoPath
combinePaths _ NoPath = NoPath
combinePaths(Path p1 w1) (Path (ph2:pr2) w2)
	| (last p1) == ph2 = Path (p1++pr2) (w1+w2)
	| otherwise = NoPath

minPath :: [Path a] -> Path a
minPath paths = foldr minOfTwoPaths NoPath paths
	where minOfTwoPaths path NoPath = path
	      minOfTwoPaths NoPath path = path
	      minOfTwoPaths(Path p1 w1) (Path p2 w2)
	     	| w2 < w1 = Path p2 w2
	      	| w1 < w2 = Path p1 w1
	      	| length p2 < length p1 = Path p2 w2
	      	| otherwise = Path p1 w1 

shortestPath :: (Ord a) => a -> a -> Graph a -> Path a
shortestPath start end graph 
	| not $ hasVertex start graph = NoPath
	| not $ hasVertex end graph = NoPath 	
	| areDirectlyConnected start end graph = edgeAsPath $ getEdge start end graph
	| otherwise = minPath $ map explorePaths $ getEdges start graph
			where explorePaths (Just (a, w, b)) = combinePaths (Path [a, b] w) (shortestPath b end remainingGraph)
			      explorePaths Nothing = NoPath
			      remainingGraph = deleteVertex start graph
