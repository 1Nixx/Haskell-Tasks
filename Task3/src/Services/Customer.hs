{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# LANGUAGE TypeApplications #-}

module Services.Customer
    ( getCustomers
    , getCustomer
    , addCustomer
    , editCustomer
    , deleteCustomer
    , searchCustomers) where

import Data.Models (CustomerModel)
import Data.Entities (Customer (..))
import qualified Repositories.OrderRepository as OrderRep
import qualified Repositories.ProductRepository as ProductRep
import Repositories.GenericRepository.GenericRepository
import Mappings.Mappings (mapCustomerToModel)
import Data.SearchModels (CustomerSearchModel(..))
import Repositories.FilterApplier (applyFilter)
import Data.List (isInfixOf)
import Utils.Utils (unwrap)

getCustomers :: IO [CustomerModel]
getCustomers = map (\o -> mapCustomerToModel o Nothing Nothing) <$> getList

getCustomer :: Int -> IO (Maybe CustomerModel)
getCustomer custId =
    unwrap $ get custId >>= \maybeCustomer -> 
        return (maybeCustomer >>= \customer -> 
            let orders = OrderRep.getOrdersByCustomerId custId 
                prodWithIds = ProductRep.getProductsWithOrdersId
            in  return $ (\ord prodId -> Just . mapCustomerToModel customer (Just ord) . Just $ prodId) <$> orders <*> prodWithIds)

addCustomer :: CustomerModel -> IO Int
addCustomer customer =
    let customer' = mapModelToCutomer customer
    in add customer'

editCustomer :: CustomerModel -> IO ()
editCustomer customer =
    let customer' = mapModelToCutomer customer
    in edit customer'

deleteCustomer :: Int -> IO ()
deleteCustomer = delete @Customer

searchCustomers :: CustomerSearchModel -> IO [CustomerModel]
searchCustomers model =
    map (\o -> mapCustomerToModel o Nothing Nothing) <$> search filterFunc model 
    where
        filterFunc :: CustomerSearchModel -> [Customer] -> [Customer]
        filterFunc filters =
            applyFilter customerName customerSearchModelName isInfixOf filters
          . applyFilter customerAddress customerSearchModelAddress isInfixOf filters