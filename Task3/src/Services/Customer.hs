module Services.Customer
    ( getCustomers
    , getCustomer
    , addCustomer
    , editCustomer
    , deleteCustomer) where

import Data.Models (CustomerModel)
import qualified Repositories.Customers as CustomerRep
import qualified Repositories.Orders as OrderRep
import qualified Repositories.Products as ProductRep
import Mappings.Mappings (mapCustomerToModel, mapModelToCutomer)

getCustomers :: IO [CustomerModel]
getCustomers = do
    csts <- CustomerRep.getCustomers 
    return (map (\o -> mapCustomerToModel o Nothing Nothing) csts)

getCustomer :: Int -> IO (Maybe CustomerModel)
getCustomer custId = do
    customer <- CustomerRep.getCustomerById custId
    case customer of
        Nothing -> return Nothing
        Just value -> do
            orders <- OrderRep.getOrdersByCustomerId custId
            prodWithIds <- ProductRep.getProductsWithOrdersId
            return (Just . mapCustomerToModel value (Just orders) . Just $ prodWithIds)

addCustomer :: CustomerModel -> IO Int
addCustomer customer = 
    let customer' = mapModelToCutomer customer     
    in CustomerRep.addCustomer customer'

editCustomer :: CustomerModel -> IO ()
editCustomer customer = 
    let customer' = mapModelToCutomer customer     
    in CustomerRep.editCustomer customer'

deleteCustomer :: Int -> IO ()
deleteCustomer = CustomerRep.deleteCustomer