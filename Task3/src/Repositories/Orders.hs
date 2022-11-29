module Repositories.Orders 
    ( getOrderById
    , getOrders
    , getOrdersByCustomerId
    , addOrder
    , editOrder
    , deleteOrder) where

import Data.Entities(Order(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Data.Converters.OrderConverter (readEntity)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)

getOrderById :: Int -> IO (Maybe Order)
getOrderById searchId = do 
    ords <- getOrders
    return $ maybeHead $ filter (\a -> orderId a == searchId) ords

getOrders :: IO [Order]
getOrders = do
    ordersFile <- readEntityFields "Orders"
    return (map readEntity ordersFile)

getOrdersByCustomerId :: Int -> IO [Order]
getOrdersByCustomerId custId = do 
    ords <- getOrders
    return $ filter (\ a -> orderCustomerId a == custId) ords

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

deleteOrder :: Int -> IO ()
deleteOrder ordId = do
    oldOrders <- getOrders
    let lineId = getListId ordId oldOrders 
    deleteLine "Orders" (fromMaybe (-1) lineId)
    return()
    