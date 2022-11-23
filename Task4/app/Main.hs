{-# LANGUAGE NoImplicitPrelude #-}
module Main (main) where

import Lib
import Data.Foldable (Foldable(foldl, fold))

main :: IO ()
main = do
    print (map (*5) testArr)
    print (for testArr (+5))
    --print (while (/= 3) (*3) testArr)
    -- print (until (/= 3) (*3) testArr)
    print (filter odd testArr)
    print (all odd testOddArr)
    print (any odd testArr)
    -- print (reduce reduceIns  0 testArr)
    print (sum testArr)
    print (count testArr)
    print (max testArr)
    print (min testArr)
    print (concat testConcatArr)
    print (reverse testArr)
    -- print (take 2 testArr)
    -- print (skip 2 testArr)
    -- print (add 12818 testArr)
    -- print (insert 123 1 testArr)
    -- print (remove 4 testArr)
    -- print (removeAt 2 testArr)

testArr :: [Int]
testArr = [1, 2, 3, 4]

testOddArr :: [Int]
testOddArr = [1, 3, 5]

testConcatArr :: [[Int]]
testConcatArr = [[1, 2, 3], [], [5, 6, 8]]

reduceIns :: Int -> Int -> Int
reduceIns a b = a + b * 3