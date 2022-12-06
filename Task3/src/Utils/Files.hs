module Utils.Files (readEntityFields, deleteLine, addLine, replaceLine) where

import System.IO
    ( hClose, hGetContents, openFile, IOMode(ReadMode) )
import qualified Data.Text as Text

readEntityFromFile :: String -> IO String
readEntityFromFile entityName =
    openFile (fileName entityName) ReadMode >>= \input -> 
        hGetContents input >>= \text ->
        putStrLn text >>
        hClose input >>
        return text

writeEntityToFile :: String -> String -> IO ()
writeEntityToFile entityName = writeFile (fileName entityName)

readEntityFields :: String -> IO [[String]]
readEntityFields entityName =
    readEntityFromFile entityName >>=
    mapM (return . map Text.unpack . Text.split (=='|') . Text.pack ) . lines

deleteLine :: String -> Int -> IO ()
deleteLine entityName lineInd =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines $ removeAt lineInd rows
        in writeEntityToFile entityName resultRows

addLine :: String -> String -> IO ()
addLine entityName line =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines (rows ++ [line])
        in writeEntityToFile entityName resultRows

replaceLine :: String -> String -> Int -> IO ()
replaceLine entityName line lineInd =
    readEntityFromFile entityName >>= \text -> 
        let rows = lines text
            resultRows = unlines $ replaceAt lineInd line rows
        in writeEntityToFile entityName resultRows

fileName :: String -> String
fileName entityName = "src/Files/" ++ entityName ++ ".txt"

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