module Utils.Files (readEntityFields, deleteLine, addLine, replaceLine) where

import System.IO
    ( hClose, hGetContents, openFile, IOMode(ReadMode) )
import qualified Data.Text as Text
import Data.App (App (..), AppConfig (filePath))
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Reader (MonadReader(ask))

readEntityFromFile :: String -> App String
readEntityFromFile entityName =
    ask >>= \config ->
    liftIO $ openFile (fileName (filePath config) entityName) ReadMode >>= \input -> 
        hGetContents input >>= \text ->
        putStrLn text >>
        hClose input >>
        return text

writeEntityToFile :: String -> String -> App ()
writeEntityToFile entityName text = 
    ask >>= \config ->
    liftIO $ writeFile (fileName (filePath config) entityName) text

readEntityFields :: String -> App [[String]]
readEntityFields entityName =
    readEntityFromFile entityName >>=
    mapM (return . map Text.unpack . Text.split (=='|') . Text.pack ) . lines

deleteLine :: String -> Int -> App ()
deleteLine entityName lineInd =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines $ removeAt lineInd rows
        in writeEntityToFile entityName resultRows

addLine :: String -> String -> App ()
addLine entityName line =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines (rows ++ [line])
        in writeEntityToFile entityName resultRows

replaceLine :: String -> String -> Int -> App ()
replaceLine entityName line lineInd =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines $ replaceAt lineInd line rows
        in writeEntityToFile entityName resultRows

fileName :: String -> String -> String
fileName path entityName = path ++ entityName ++ ".txt"

removeAt :: Int -> [a] -> [a]
removeAt pos xs'@(x:xs)
  | pos > 0   = x : removeAt (pos - 1) xs
  | pos == 0  = xs
  | otherwise = xs'
removeAt _ [] = []

replaceAt :: Int -> a -> [a] -> [a]
replaceAt pos el xs'@(x:xs)
    | pos > 0   = x : replaceAt (pos - 1) el xs
    | pos == 0  = el : xs
    | otherwise = xs'
replaceAt _ _ [] = []