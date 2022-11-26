module Repositories.Orders 
    ( getOrderById
    , getOrders
    , getOrdersByCustomerId) where

import Data.Entities(Order(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields)
import Data.Converters.OrderConverter (readEntity)

getOrderById :: Int -> IO (Maybe Order)
getOrderById searchId = maybeHead . filter (\a -> orderId a == searchId) <$> getOrders

getOrders :: IO [Order]
getOrders = do
    ordersFile <- readEntityFields "Orders"
    return (map readEntity ordersFile)

getOrdersByCustomerId :: Int -> IO [Order]
getOrdersByCustomerId custId = filter (\ a -> orderCustomerId a == custId) <$> getOrders