module Repositories.Orders 
    ( getOrderById
    , getOrders
    , getOrdersByCustomerId) where

import Data.Entities(Order(..))
import Data.Context (orders)
import Utils.Utils (maybeHead)

getOrderById :: Int -> Maybe Order
getOrderById searchId = maybeHead $ filter (\a -> orderId a == searchId) getOrders

getOrders :: [Order]
getOrders = orders

getOrdersByCustomerId :: Int -> [Order]
getOrdersByCustomerId custId = filter (\ a -> orderCustomerId a == custId) getOrders

toWrite :: Order -> String
toWrite ord = show (orderId ord) ++ "|" ++ show (orderCustomerId ord) ++ "|" ++ orderNumber ord