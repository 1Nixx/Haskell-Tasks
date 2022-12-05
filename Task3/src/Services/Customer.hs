{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use lambda-case" #-}

module Services.Customer
    ( getCustomers
    , getCustomer
    , addCustomer
    , editCustomer
    , deleteCustomer) where

import Data.Models (CustomerModel)
import Data.Entities (Customer (Customer))
import qualified Repositories.OrderRepository as OrderRep
import qualified Repositories.ProductRepository as ProductRep
import Repositories.GenericRepository.GenericRepository
import Mappings.Mappings (mapCustomerToModel, mapModelToCutomer)


getCustomers :: IO [CustomerModel]
getCustomers = map (\o -> mapCustomerToModel o Nothing Nothing) <$> getList

getCustomer :: Int -> IO (Maybe CustomerModel)
getCustomer custId =
    get custId >>= \custRes ->
        case custRes of
            Nothing -> return Nothing
            Just value ->
                OrderRep.getOrdersByCustomerId custId >>= \orders ->
                ProductRep.getProductsWithOrdersId >>= \prodWithIds ->
                return $ Just . mapCustomerToModel value (Just orders) . Just $ prodWithIds

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