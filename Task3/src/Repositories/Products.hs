module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId) where

import Data.Entities (Product(..), productId, ProductOrder (..))
import Data.Context (products, productOrders)

getProductById :: Int -> Product
getProductById searchId = head $ filter (\a -> productId a == searchId) products

getProducts :: [Product]
getProducts = products

getProductsByOrderId :: Int -> [Product]
getProductsByOrderId searchOrderId = map (getProductById . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders
   

