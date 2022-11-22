module Repositories.Customers 
    ( getCustomerById
    , getCustomers) where

import Data.Entities (Customer(..))
import Data.Context (customers)
import Utils.Utils (maybeHead)

getCustomerById :: Int -> Maybe Customer
getCustomerById searchId = maybeHead $ filter (\a -> customerId a == searchId) getCustomers

getCustomers :: [Customer]
getCustomers = customers