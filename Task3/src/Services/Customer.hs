module Services.Customer
    ( getCustomers
    , getCustomer
    , addCustomer
    , editCustomer) where

import Data.Models (CustomerModel)
import qualified Repositories.Customers as CustomerRep
import qualified Repositories.Orders as OrderRep
import qualified Repositories.Products as ProductRep
import Mappings.Mappings (mapCustomerToModel, mapModelToCutomer)

getCustomers :: IO [CustomerModel]
getCustomers = map (\o -> mapCustomerToModel o Nothing Nothing) <$> CustomerRep.getCustomers

getCustomer :: Int -> IO (Maybe CustomerModel)
getCustomer custId = do
    customer <- CustomerRep.getCustomerById custId
    case customer of
        Nothing -> return Nothing
        Just value -> do
            orders <- OrderRep.getOrdersByCustomerId custId
            Just . mapCustomerToModel value (Just orders) . Just <$> ProductRep.getProductsWithOrdersId

addCustomer :: CustomerModel -> IO Int
addCustomer customer = 
    let customer' = mapModelToCutomer customer     
    in CustomerRep.addCustomer customer'

editCustomer :: CustomerModel -> IO ()
editCustomer customer = 
    let customer' = mapModelToCutomer customer     
    in CustomerRep.editCustomer customer'
