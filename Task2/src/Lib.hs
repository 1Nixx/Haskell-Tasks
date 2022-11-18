{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
{-# OPTIONS_GHC -Wno-dodgy-imports #-}
module Lib
    ( module Prelude,
      map,
      for,
      while,
      until,
      filter,
      all,
      any,
      reduce,
      sum,
      count,
      concat,
      reverse,
      take,
      skip,
      add,
      insert,
      remove,
      removeAt     
    ) where

import Prelude hiding 
  (map, until, filter, all, any, sum, concat, reverse, take, skip)

map :: (a -> b) -> [a] -> [b]
map f (x:xs) = f x : map f xs
map _ [] = []

for :: [a] -> (a -> b) -> [b]
for (x:xs) f = f x : for xs f 
for [] _ = []

while :: (a -> Bool) -> (a -> b) -> [a] -> [b]
while cond f (x:xs)
  | cond x    = f x : while cond f xs
  | otherwise = []
while _ _ [] = []

until :: (a -> Bool) -> (a -> b) -> [a] -> [b]
until cond f (x:xs) 
  | cond x = f x : until cond f xs
  | otherwise = [f x]
until _ _ [] = []

filter :: (a -> Bool) -> [a] -> [a]
filter p (x:xs)
  | p x       = x : filter p xs
  | otherwise = filter p xs
filter _ [] = []

all :: (a -> Bool) -> [a] -> Bool
all f (x:xs)
  | f x       = all f xs
  | otherwise = False
all _ [] = True

any :: (a -> Bool) -> [a] -> Bool
any f (x:xs)
  | f x = True
  | otherwise = any f xs
any _ [] = False

reduce :: (a -> b -> a) -> a -> [b] -> a
reduce f acc (x:xs) =
  let acc' = f acc x
  in reduce f acc' xs
reduce _ acc [] = acc

sum :: [Int] -> Int
sum (x:xs) = x + sum xs
sum [] = 0

count :: [a] -> Int
count = helpCount 0
  where 
    helpCount a (_:xs) = helpCount (a + 1) xs
    helpCount a [] = a

concat :: [[a]] -> [a]
concat [] = []
concat ([]:vs) = concat vs
concat ((x:xs):vs) = x : concat (xs:vs)

reverse :: [a] -> [a]
reverse arr = rev arr []
  where
    rev [] a     = a
    rev (x:xs) a = rev xs (x:a)

take :: Int -> [a] -> [a]
take c (x:xs)
  | c > 0     = x : take (c - 1) xs
  | otherwise = []
take _ [] = []

skip :: Int -> [a] -> [a]
skip c xs'@(_:xs)
  | c > 1     = skip (c - 1) xs
  | c < 1     = xs'
  | c == 1    = xs
  | otherwise = []
skip _ [] = []

add :: a -> [a] -> [a]
add el (x:xs) = x : add el xs
add el [] = [el]

insert :: a -> Int -> [a] -> [a]
insert el pos (x:xs)
  | pos > 0   = x : insert el (pos - 1) xs
  | pos < 0   = error "Invalid pos"
  | pos == 0  = el : (x:xs)
  | otherwise = x:xs
insert _ _ [] = []

remove :: (Eq a) => a -> [a] -> [a]
remove el (x:xs) 
  | el /= x   = x : remove el xs
  | otherwise = remove el xs
remove _ [] = []

removeAt :: Int -> [a] -> [a]
removeAt pos xs'@(x:xs)
  | pos > 0   = x : removeAt (pos - 1) xs
  | pos == 0  = xs
  | otherwise = xs'
removeAt _ [] = [] 



