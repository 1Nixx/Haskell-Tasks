module Utils.Files (readEntityFields, deleteLine, addLine, replaceLine) where

import System.IO
    ( hClose, hGetContents, openFile, IOMode(ReadMode) )
import qualified Data.Text as Text

readEntityFile :: String -> IO String
readEntityFile entityName = do
    input <- openFile (fileName entityName) ReadMode
    text <- hGetContents input
    putStrLn text
    hClose input
    return text

writeEntityFile :: String -> String -> IO ()
writeEntityFile entityName text = do
    writeFile (fileName entityName) text

readEntityFields :: String -> IO [[String]]
readEntityFields entityName = do
    text <- readEntityFile entityName
    let splitByFields = map (map Text.unpack . Text.split (=='|') . Text.pack ) (lines text)
    return splitByFields

deleteLine :: String -> Int -> IO ()
deleteLine entityName lineInd = do
    text <- readEntityFile entityName
    let rows = lines text
    let resultRows = unlines $ removeAt lineInd rows
    writeEntityFile entityName resultRows

addLine :: String -> String -> IO ()
addLine entityName line = do
    text <- readEntityFile entityName
    let rows = lines text
    let resultRows = unlines (rows ++ [line])
    writeEntityFile entityName resultRows

replaceLine :: String -> String -> Int -> IO ()
replaceLine entityName line lineInd = do
    text <- readEntityFile entityName
    let rows = lines text
    let resultRows = unlines $ replaceAt lineInd line rows
    writeEntityFile entityName resultRows

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