{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
module Lib
    ( mapFunc,
      forFunc,
      whileFunc,
      untilFunc,
      filterFunc,
      allFunc,
      anyFunc,
      reduceFunc,
      sumFunc,
      countFunc,
      concatFunc,
      reverseFunc,
      takeFunc,
      skipFunc,
      addFunc,
      insertFunc,
      removeAtFunc,
      removeFunc
    ) where

mapFunc :: (a -> b) -> [a] -> [b]
mapFunc f (x:xs) = f x : mapFunc f xs
mapFunc _ [] = []

forFunc :: [a] -> (a -> b) -> [b]
forFunc (x:xs) f = f x : forFunc xs f 
forFunc [] _ = []

whileFunc :: (a -> Bool) -> (a -> b) -> [a] -> [b]
whileFunc cond f (x:xs)
  | cond x    = f x : whileFunc cond f xs
  | otherwise = []
whileFunc _ _ [] = []

untilFunc :: (a -> Bool) -> (a -> b) -> [a] -> [b]
untilFunc cond f (x:xs) 
  | cond x = f x : untilFunc cond f xs
  | otherwise = [f x]
untilFunc _ _ [] = []

filterFunc :: (a -> Bool) -> [a] -> [a]
filterFunc p (x:xs)
  | p x       = x : filterFunc p xs
  | otherwise = filterFunc p xs
filterFunc _ [] = []

allFunc :: (a -> Bool) -> [a] -> Bool
allFunc f (x:xs)
  | f x       = allFunc f xs
  | otherwise = False
allFunc _ [] = True

anyFunc :: (a -> Bool) -> [a] -> Bool
anyFunc f (x:xs)
  | f x = True
  | otherwise = anyFunc f xs
anyFunc _ [] = False

reduceFunc :: (a -> b -> a) -> a -> [b] -> a
reduceFunc f acc (x:xs) =
  let acc' = f acc x
  in reduceFunc f acc' xs
reduceFunc _ acc [] = acc

sumFunc :: [Int] -> Int
sumFunc (x:xs) = x + sumFunc xs
sumFunc [] = 0

countFunc :: [a] -> Int
countFunc = helpCount 0
  where 
    helpCount a (_:xs) = helpCount (a + 1) xs
    helpCount a [] = a

concatFunc :: [[a]] -> [a]
concatFunc [] = []
concatFunc ([]:vs) = concatFunc vs
concatFunc ((x:xs):vs) = x : concatFunc (xs:vs)

reverseFunc :: [a] -> [a]
reverseFunc arr = rev arr []
  where
    rev [] a     = a
    rev (x:xs) a = rev xs (x:a)

takeFunc :: Int -> [a] -> [a]
takeFunc c (x:xs)
  | c > 0     = x : takeFunc (c - 1) xs
  | otherwise = []
takeFunc _ [] = []

skipFunc :: Int -> [a] -> [a]
skipFunc c xs'@(_:xs)
  | c > 1     = skipFunc (c - 1) xs
  | c < 1     = xs'
  | c == 1    = xs
  | otherwise = []
skipFunc _ [] = []

addFunc :: a -> [a] -> [a]
addFunc el (x:xs) = x : addFunc el xs
addFunc el [] = [el]

insertFunc :: a -> Int -> [a] -> [a]
insertFunc el pos (x:xs)
  | pos > 0   = x : insertFunc el (pos - 1) xs
  | pos < 0   = error "Invalid pos"
  | pos == 0  = el : (x:xs)
  | otherwise = x:xs
insertFunc _ _ [] = []

removeFunc :: (Eq a) => a -> [a] -> [a]
removeFunc el (x:xs) 
  | el /= x   = x : removeFunc el xs
  | otherwise = removeFunc el xs
removeFunc _ [] = []

removeAtFunc :: Int -> [a] -> [a]
removeAtFunc pos xs'@(x:xs)
  | pos > 0   = x : removeAtFunc (pos - 1) xs
  | pos == 0  = xs
  | otherwise = xs'
removeAtFunc _ [] = [] 



