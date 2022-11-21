module Repositories.Customers 
    ( getCustomerById
    , getCustomers) where

import Data.Entities (Customer(..))
import Data.Context (customers)

getCustomerById :: Int -> Customer
getCustomerById searchId = head $ filter (\a -> customerId a == searchId) customers

getCustomers :: [Customer]
getCustomers = customers