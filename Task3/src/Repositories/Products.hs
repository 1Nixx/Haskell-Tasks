module Repositories.Products 
    ( getProductById
    , getProducts) where

import Data.Entities (Product(..), productId)
import Data.Context (products)

getProductById :: Int -> Product
getProductById searchId = head $ filter (\a -> productId a == searchId) products

getProducts :: [Product]
getProducts = products
