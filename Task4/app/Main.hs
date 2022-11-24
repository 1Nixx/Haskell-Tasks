{-# LANGUAGE NoImplicitPrelude #-}
module Main (main) where

import Lib
import Data.Foldable (Foldable(foldl, fold))
import Data.String (String)

main :: IO ()
main = do
    print (map (*5) testArr)
    print (for testArr (+5))
    print (while (< 2)  (*3) testArr)
    print (until (/= 2) (*3) testArr)
    print (filter odd testArr)
    print (all odd testOddArr)
    print (any odd testArr)
    print (reduce reduceIns  0 testArr)
    print (sum testArr)
    print (count testArr)
    print (max testArr)
    print (min testArr)
    print (concat testConcatArr)
    print (reverse testArr)
    print (take 2 testArr)
    print (skip 2 testArr)
    print (add 12818 testArr)
    print (insert 123 1 testArr)
    print (remove 4 testArr)
    print (removeAt 1 testArr) 
    print (groupBy (\x y -> (x*y `mod` 3) == 0) [1,2,3,4,5,6,7,8,9])
    print (groupBy (\x y -> productPrice x == productPrice y) testProductList)
    

testProductList :: [Product]
testProductList = [
        Product {
            productId = 1,
            productName = "Test1",
            productPrice = 45.55
        },
        Product {
            productId = 2,
            productName = "Test2",
            productPrice = 23.8
        },
        Product {
            productId = 3,
            productName = "Test3",
            productPrice = 83.9
        },
        Product {
            productId = 5,
            productName = "Test5",
            productPrice = 83.9
        },
        Product {
            productId = 4,
            productName = "Test4",
            productPrice = 30.5
        }
    ]

testArr :: [Int]
testArr = [1, 2, 3, 4]

testOddArr :: [Int]
testOddArr = [1, 3, 5]

testConcatArr :: [[Int]]
testConcatArr = [[1, 2, 3], [], [5, 6, 8]]

reduceIns :: Int -> Int -> Int
reduceIns a b = a + b * 3

data Product = Product {
    productId :: Int,
    productName :: String,
    productPrice :: Double
} deriving (Show)