module Main (main) where

import Lib

main :: IO ()
main = do
    print (mapFunc (*5) testArr)
    print (forFunc testArr (+5))
    print (whileFunc (/= 3) (*3) testArr)
    print (untilFunc (/= 3) (*3) testArr)
    print (filterFunc odd testArr)
    print (allFunc odd testOddArr)
    print (anyFunc odd testArr)
    print (reduceFunc reduceInsFunc 0 testArr)
    print (sumFunc testArr)
    print (countFunc testArr)
    print (concatFunc testConcatArr)
    print (reverse testArr)
    print (takeFunc 2 testArr)
    print (skipFunc 2 testArr)
    print (addFunc 12818 testArr)
    print (insertFunc 123 1 testArr)
    print (removeFunc 4 testArr)
    print (removeAtFunc 2 testArr)

testArr :: [Int]
testArr = [1, 2, 3, 4]

testOddArr :: [Int]
testOddArr = [1, 3 ,5]

testConcatArr :: [[Int]]
testConcatArr = [[1, 2, 3], [], [5, 6, 8]]

reduceInsFunc :: Int -> Int -> Int
reduceInsFunc a b = a + b * 3
