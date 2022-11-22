module Services.Customer
    ( getCustomers
    , getCustomer) where

import Data.Models (CustomerModel)
import qualified Repositories.Customers as CustomerRep
import qualified Repositories.Orders as OrderRep
import Mappings.Mappings (mapCustomerToModel)
import Repositories.Products (getProductsByOrderId)

getCustomers :: [CustomerModel]
getCustomers = map (\o -> mapCustomerToModel o Nothing Nothing) CustomerRep.getCustomers

getCustomer :: Int -> Maybe CustomerModel
getCustomer custId =
    let orders = Just $ OrderRep.getOrdersByCustomerId custId
        customer = CustomerRep.getCustomerById custId
    in case customer of
        Nothing -> Nothing
        Just value -> Just $ mapCustomerToModel value orders (Just getProductsByOrderId)
