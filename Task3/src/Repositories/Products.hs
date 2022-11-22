module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..))
import Data.Context (products, productOrders)
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust)

getProductById :: Int -> Maybe Product
getProductById searchId = maybeHead $ filter (\a -> productId a == searchId) products

getProducts :: [Product]
getProducts = products

getProductsByOrderId :: Int -> [Product]
getProductsByOrderId searchOrderId = map (fromJust . getProductById . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> [Product]
getProductsByShopId searchShopId = filter (\ a -> productShopId a == searchShopId) products

