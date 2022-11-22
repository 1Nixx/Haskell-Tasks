module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..), Order(..))
import Data.Context (products, productOrders)
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust)
import Repositories.Orders (getOrders) 

getProductById :: Int -> Maybe Product
getProductById searchId = maybeHead $ filter (\a -> productId a == searchId) getProducts

getProducts :: [Product]
getProducts = products

getProductsByOrderId :: Int -> [Product]
getProductsByOrderId searchOrderId = map (fromJust . getProductById . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> [Product]
getProductsByShopId searchShopId = filter (\ a -> productShopId a == searchShopId) getProducts

getProductsWithOrdersId :: [(Int, [Product])]
getProductsWithOrdersId = 
    let orderIds = getOrders
    in itterate orderIds
    where 
        itterate :: [Order] -> [(Int, [Product])]
        itterate (x:xs) = (orderId x, getProductsByOrderId $ orderId x) : itterate xs
        itterate [] = []