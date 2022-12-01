module Services.Customer
    ( getCustomers
    , getCustomer
    , addCustomer
    , editCustomer
    , deleteCustomer) where

import Data.Models (CustomerModel)
import Data.Entities (Customer)
import qualified Repositories.OrderRepository as OrderRep
import qualified Repositories.ProductRepository as ProductRep
import Repositories.GenericRepository.GenericRepository
import Mappings.Mappings (mapCustomerToModel, mapModelToCutomer)


getCustomers :: IO [CustomerModel]
getCustomers = do
    csts <- getList ofEntity
    return (map (\o -> mapCustomerToModel o Nothing Nothing) csts)

getCustomer :: Int -> IO (Maybe CustomerModel)
getCustomer custId = do
    customer <- get ofEntity custId
    case customer of
        Nothing -> return Nothing
        Just value -> do
            orders <- OrderRep.getOrdersByCustomerId custId
            prodWithIds <- ProductRep.getProductsWithOrdersId
            return (Just . mapCustomerToModel value (Just orders) . Just $ prodWithIds)

addCustomer :: CustomerModel -> IO Int
addCustomer customer =
    let customer' = mapModelToCutomer customer
    in add customer'

editCustomer :: CustomerModel -> IO ()
editCustomer customer =
    let customer' = mapModelToCutomer customer
    in edit customer'

deleteCustomer :: Int -> IO ()
deleteCustomer = delete (ofEntity :: Customer)