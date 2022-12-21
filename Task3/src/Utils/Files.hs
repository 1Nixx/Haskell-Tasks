module Utils.Files (readAllEntities, deleteEntity, insertEntity, updateEntity) where

import System.IO
    ( hClose, hGetContents, openFile, IOMode(ReadMode) )
import qualified Data.Text as Text
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Reader (MonadReader(ask))
import Data.AppTypes (App, filePath)

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

readAllEntities :: String -> App [[String]]
readAllEntities entityName =
    readEntityFromFile entityName >>=
    mapM (return . map Text.unpack . Text.split (=='|') . Text.pack ) . lines

deleteEntity :: String -> Int -> App ()
deleteEntity entityName lineInd =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines $ removeAt lineInd rows
        in writeEntityToFile entityName resultRows

insertEntity :: String -> String -> App ()
insertEntity entityName line =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines (rows ++ [line])
        in writeEntityToFile entityName resultRows

updateEntity :: String -> String -> Int -> App ()
updateEntity entityName line lineInd =
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