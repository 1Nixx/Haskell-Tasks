module Repositories.Orders 
    ( getCustomerById
    , getOrders) where

import Data.Entities(Order(..))
import Data.Context (orders)

getCustomerById :: Int -> Order
getCustomerById searchId = head $ filter (\a -> orderId a == searchId) orders

getOrders :: [Order]
getOrders = orders