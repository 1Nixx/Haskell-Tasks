{-# OPTIONS_GHC -Wno-overlapping-patterns #-}

module Repositories.Customers
    ( getCustomerById
    , getCustomers
    , addCustomer) where

import Data.Entities (Customer(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields, addLine)
import Data.Converters.CustomerConverter (readEntity)

getCustomerById :: Int -> IO (Maybe Customer)
getCustomerById searchId = do
    maybeHead . filter (\a -> customerId a == searchId) <$> getCustomers

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