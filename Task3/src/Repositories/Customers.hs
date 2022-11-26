module Repositories.Customers
    ( getCustomerById
    , getCustomers) where

import Data.Entities (Customer(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields)
import Data.Converters.CustomerConverter (readEntity)

getCustomerById :: Int -> IO (Maybe Customer)
getCustomerById searchId = do
    maybeHead . filter (\a -> customerId a == searchId) <$> getCustomers

getCustomers :: IO [Customer]
getCustomers = do
    customersFile <- readEntityFields "Customers"
    return (map readEntity customersFile)