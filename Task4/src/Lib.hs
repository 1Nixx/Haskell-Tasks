module Lib
    ( module Prelude
    , foldl
    , foldr
    , foldl'
    , map
    , for
    , filter
    , all
    , any
    , sum
    , count
    , max
    , min
    , reduce
    , concat) where

import Prelude hiding
    (map, foldl, foldr, filter, all, any, sum, max, min, concat)

foldl :: (a -> b -> a) -> a -> [b] -> a
foldl step var (x:xs) = foldl step (step var x) xs
foldl _ var [] = var

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr step var (x:xs) = step x $ foldr step var xs
foldr _ var [] = var

foldl' :: (a -> b -> a) -> a -> [b] -> a
foldl' _    zero []     = zero
foldl' step zero (x:xs) =
    let new = step zero x
    in  new `seq` foldl' step new xs

map :: (a -> b) -> [a] -> [b]
map f = foldr (\y ys -> f y:ys) []

for :: [a] -> (a -> b) -> [b]
for xs f = foldr (\y ys -> f y:ys) [] xs

filter :: (a -> Bool) -> [a] -> [a]
filter cond = foldr (\y ys -> if cond y then y : ys
                              else ys) []

all :: (a -> Bool) -> [a] -> Bool
all cond xs = 0 == foldl (\ys y -> if cond y then ys
                                   else ys + 1) 0 xs

any :: (a -> Bool) -> [a] -> Bool
any cond xs = 0 /= foldl (\ys y -> if cond y then ys + 1
                                    else ys) 0 xs

sum :: Num a => [a] -> a
sum = foldl (+) 0

count :: [a] -> Int
count = foldl (\ys _ -> ys + 1) 0

max :: Ord a => [a] -> a
max (x:xs) = foldl (\ ys y -> if y > ys then y else ys) x xs

min :: Ord a => [a] -> a
min (x:xs) = foldl (\ ys y -> if y < ys then y else ys) x xs

reduce :: (a -> b -> a) -> a -> [b] -> a
reduce = foldl

concat :: [[a]] -> [a]
concat = foldl (++) []

reverse :: [a] -> [a]
reverse = foldl (\ys y -> y : ys) []

