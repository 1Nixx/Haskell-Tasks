module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId
    , isProductInOrder) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..))
import Data.Context (products, productOrders)
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust)

getProductById :: Int -> Maybe Product
getProductById searchId = maybeHead $ filter (\a -> productId a == searchId) getProducts

getProducts :: [Product]
getProducts = products

getProductsByOrderId :: Int -> [Product]
getProductsByOrderId searchOrderId = map (fromJust . getProductById . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> [Product]
getProductsByShopId searchShopId = filter (\ a -> productShopId a == searchShopId) getProducts

isProductInOrder :: Product -> Int -> Bool
isProductInOrder prod ordId = any (\ a -> orderFKId a == ordId && prodFKId a == productId prod) productOrders