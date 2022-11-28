module Repositories.Orders 
    ( getOrderById
    , getOrders
    , getOrdersByCustomerId
    , addOrder
    , editOrder) where

import Data.Entities(Order(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields, addLine, replaceLine)
import Data.Converters.OrderConverter (readEntity)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)

getOrderById :: Int -> IO (Maybe Order)
getOrderById searchId = maybeHead . filter (\a -> orderId a == searchId) <$> getOrders

getOrders :: IO [Order]
getOrders = do
    ordersFile <- readEntityFields "Orders"
    return (map readEntity ordersFile)

getOrdersByCustomerId :: Int -> IO [Order]
getOrdersByCustomerId custId = filter (\ a -> orderCustomerId a == custId) <$> getOrders

addOrder :: Order -> IO Int
addOrder ord = do
    oldOrders <- getOrders
    let ordId = getOrderUnicId oldOrders
    let newOrd = ord { orderId = ordId }
    addLine "Orders" (show newOrd)
    return ordId

getOrderUnicId :: [Order] -> Int
getOrderUnicId xs = orderId (last xs) + 1  

editOrder :: Order -> IO ()
editOrder ord = do
    oldOrders <- getOrders
    let lineId = getListId (orderId ord) oldOrders 
    replaceLine "Orders" (show ord) (fromMaybe (-1) lineId)
    return()

getListId :: Int -> [Order] -> Maybe Int
getListId ordId = findIndex (\x -> orderId x == ordId) 