{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Repositories.ProductRepository
    (getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId) where

import Data.Entities (Product(..), productShopId, ProductOrder (..), Order(..))
import Data.Maybe (fromJust)
import Repositories.GenericRepository.GenericRepository

getProductsByOrderId :: Int -> IO [Product]
getProductsByOrderId searchOrderId = do
    productOrders <- getList (ofEntity :: ProductOrder) 
    mapM (fmap fromJust . get (ofEntity :: Product) . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> IO [Product]
getProductsByShopId searchShopId = do
    prds <- getList (ofEntity :: Product) 
    return $ filter (\ a -> productShopId a == searchShopId) prds

getProductsWithOrdersId :: IO [(Int, [Product])]
getProductsWithOrdersId = do
    orders <- getList (ofEntity :: Order) 
    mapM step orders
    where
        step :: Order -> IO (Int, [Product])
        step ord = do
            let orderid = orderId ord
            products <- getProductsByOrderId orderid
            return (orderid, products)