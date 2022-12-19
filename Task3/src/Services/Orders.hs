module Services.Orders (getOrder) where

import Data.Models (OrderModel)
import Data.Entities (Order(orderCustomerId, orderId), Customer, Product)
import qualified Repositories.ProductRepository as ProdRep
import qualified Services.GenericService as S
import qualified Repositories.GenericRepository.GenericRepository as R
import Data.AppTypes ( App ) 

getOrder :: Int -> App OrderModel
getOrder =
    S.get getParams
    where
        getParams :: Order -> App (Maybe Customer, Maybe [Product])
        getParams order =
            R.get (orderCustomerId order) >>= \customer ->
            ProdRep.getProductsByOrderId (orderId order) >>= \products ->
            return (Just customer, Just products)