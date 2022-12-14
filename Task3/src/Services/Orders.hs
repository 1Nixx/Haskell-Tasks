module Services.Orders (getOrder) where

import Data.Models (OrderModel)
import Data.Entities (Order(orderCustomerId, orderId), Customer, Product)
import qualified Repositories.ProductRepository as ProdRep
import qualified Services.GenericService as S
import qualified Repositories.GenericRepository.GenericRepository as R
import Data.App (App)

getOrder :: Int -> App (Maybe OrderModel)
getOrder =
    S.get getParams
    where
        getParams :: Order -> App (Maybe Customer, Maybe [Product])
        getParams order =
            R.get (orderCustomerId order) >>= \maybeCustomer ->
            ProdRep.getProductsByOrderId (orderId order) >>= \products ->
            return (maybeCustomer, Just products)