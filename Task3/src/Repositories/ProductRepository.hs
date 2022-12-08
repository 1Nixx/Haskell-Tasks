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
getProductsByOrderId searchOrderId =
    getList >>= \productOrders ->
    mapM (fmap fromJust . get . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> IO [Product]
getProductsByShopId searchShopId = filter (\ a -> productShopId a == searchShopId) <$> getList

getProductsWithOrdersId :: IO [(Int, [Product])]
getProductsWithOrdersId =
    getList >>= mapM step
    where
        step :: Order -> IO (Int, [Product])
        step ord =
            let orderid = orderId ord
            in getProductsByOrderId orderid >>= \products ->
            return (orderid, products)