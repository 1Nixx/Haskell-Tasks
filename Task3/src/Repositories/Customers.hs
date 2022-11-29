module Repositories.Customers
    ( getCustomerById
    , getCustomers
    , addCustomer
    , editCustomer
    , deleteCustomer) where

import Data.Entities (Customer(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Data.Converters.CustomerConverter (ReadEntity(..))
import Data.List (findIndex)
import Data.Maybe (fromMaybe)

getCustomerById :: Int -> IO (Maybe Customer)
getCustomerById searchId = do
    cstmrs <- getCustomers
    return $ maybeHead $ filter (\a -> customerId a == searchId) cstmrs

getCustomers :: IO [Customer]
getCustomers = do
    customersFile <- readEntityFields "Customers"
    return (map readEntity customersFile)

addCustomer :: Customer -> IO Int
addCustomer cust = do
    oldCustomers <- getCustomers
    let custId = getCustUnicId oldCustomers
    let newCust = cust { customerId = custId }
    addLine "Customers" (show newCust)
    return custId

getCustUnicId :: [Customer] -> Int
getCustUnicId xs = customerId (last xs) + 1  

editCustomer :: Customer -> IO ()
editCustomer cust = do
    oldCustomers <- getCustomers
    let lineId = getListId (customerId cust) oldCustomers 
    replaceLine "Customers" (show cust) (fromMaybe (-1) lineId)
    return()

getListId :: Int -> [Customer] -> Maybe Int
getListId custId = findIndex (\x -> customerId x == custId) 

deleteCustomer :: Int -> IO ()
deleteCustomer custId = do
    oldCustomers <- getCustomers
    let lineId = getListId custId oldCustomers 
    deleteLine "Customers" (fromMaybe (-1) lineId)
    return()
    