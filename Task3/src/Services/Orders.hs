{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use forM_" #-}
{-# LANGUAGE TypeApplications #-}
{-# HLINT ignore "Use lambda-case" #-}
module Services.Orders
    ( getOrders
    , getOrder
    , addOrder
    , editOrder
    , deleteOrder) where

import Data.Models (OrderModel)
import qualified Repositories.ProductRepository as ProdRep
import Mappings.Mappings (mapOrderToModel, mapModelToOrder)
import Data.Entities (Order(orderCustomerId, orderId))
import Repositories.GenericRepository.GenericRepository

getOrders :: IO [OrderModel]
getOrders = map (\ o -> mapOrderToModel o Nothing Nothing) <$> getList

getOrder :: Int -> IO (Maybe OrderModel)
getOrder ordId =
    get ordId >>= \orderRes ->
        case orderRes of
            Nothing -> return Nothing
            Just value ->
                get (orderCustomerId value) >>= \maybeCustomer ->
                ProdRep.getProductsByOrderId (orderId value) >>= \products ->
                return $ Just $ mapOrderToModel value maybeCustomer (Just products)

addOrder :: OrderModel -> IO Int
addOrder ord =
    let order' = mapModelToOrder ord
    in add order'

editOrder :: OrderModel -> IO ()
editOrder order =
    let order' = mapModelToOrder order
    in edit order'

deleteOrder :: Int -> IO ()
deleteOrder = delete @Order