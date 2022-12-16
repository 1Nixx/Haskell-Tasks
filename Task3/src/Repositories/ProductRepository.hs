{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Repositories.ProductRepository
    (getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId) where

import Data.Entities (Product(..), productShopId, ProductOrder (..), Order(..))
import Repositories.GenericRepository.GenericRepository
import Data.App (App)

getProductsByOrderId :: Int -> App [Product]
getProductsByOrderId searchOrderId =
    getList >>= \productOrders ->
    mapM (get . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> App [Product]
getProductsByShopId searchShopId = filter (\ a -> productShopId a == searchShopId) <$> getList

getProductsWithOrdersId :: App [(Int, [Product])]
getProductsWithOrdersId =
    getList >>= mapM step
    where
        step :: Order -> App (Int, [Product])
        step ord =
            let orderid = orderId ord
            in getProductsByOrderId orderid >>= \products ->
            return (orderid, products)