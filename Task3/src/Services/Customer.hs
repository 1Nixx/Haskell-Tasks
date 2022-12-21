module Services.Customer (getCustomer) where

import Data.Models (CustomerModel)
import Data.Entities (Customer (customerId), Order, Product)
import qualified Repositories.OrderRepository as OrderRep
import qualified Repositories.ProductRepository as ProductRep
import qualified Services.GenericService as S
import Data.AppTypes ( App ) 

getCustomer :: Int -> App CustomerModel
getCustomer =
    S.get getParams
    where
        getParams :: Customer -> App (Maybe [Order], Maybe [(Int, [Product])])
        getParams customer =
            OrderRep.getOrdersByCustomerId (customerId customer) >>= \orders -> 
            ProductRep.getProductsWithOrdersId >>= \prodWithIds ->
            return (Just orders, Just prodWithIds)
