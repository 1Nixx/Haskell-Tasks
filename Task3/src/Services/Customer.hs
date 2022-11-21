module Services.Customer 
    ( getCustomers
    , getCustomer) where

import Data.Models (CustomerModel (CustomerModel))
import qualified Repositories.Customers as CustomerRep

getCustomers :: [CustomerModel]
getCustomers = map (\ o -> CustomerModel 1 1 1 Nothing) CustomerRep.getCustomers

getCustomer :: Int -> Maybe CustomerModel
getCustomer custId = Nothing