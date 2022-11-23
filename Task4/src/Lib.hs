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
    , concat
    , reverse
    , take
    , skip
    , add
    , insert
    , remove
    , removeAt
    , while
    , until) where

import Prelude hiding
    (map, foldl, foldr, filter, all, any, sum, max, min, concat, reverse, take, until)

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
all cond = foldr (\y ys -> cond y && ys) True

any :: (a -> Bool) -> [a] -> Bool
any cond = foldr (\y ys -> cond y || ys) False

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

take :: Int -> [a] -> [a]
take n xs = foldr step [] (indexArr 1 xs)
    where step (i, a) rest
               | i > n     = []
               | otherwise = a:rest

skip :: Int -> [a] -> [a]
skip n xs = foldr step [] (indexArr 1 xs)
    where step (i, a) rest
               | i > n     = a:rest
               | otherwise = rest

insert :: a -> Int -> [a] -> [a]
insert el pos xs = foldr step [] (indexArr 1 xs)
    where step (i, a) rest
                | i == pos = el:a:rest
                | otherwise = a:rest

indexArr :: Enum i => i -> [a] -> [(i, a)]
indexArr i = zip [i..]

add :: a -> [a] -> [a]
add el = foldr (:) [el]

remove :: (Eq a) => a -> [a] -> [a]
remove el = foldr step []
    where step y ys
            | y == el   = ys
            | otherwise = y : ys

removeAt :: Int -> [a] -> [a]
removeAt pos xs = foldr step [] (indexArr 1 xs)
    where step (i, a) res 
                | i == pos = res
                | otherwise = a : res


while :: (a -> Bool) -> (a -> b) -> [a] -> [b]
while cond f = foldr step []
    where step el acc
              | cond el   = f el:acc
              | otherwise = []

until :: (a -> Bool) -> (a -> b) -> [a] -> [b]
until cond f = foldr step []
    where step el acc
              | cond el   = f el:acc
              | otherwise = [f el]