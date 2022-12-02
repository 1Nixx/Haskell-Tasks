{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use forM_" #-}
{-# LANGUAGE TypeApplications #-}
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
getOrders = do
    ords <- getList
    return (map (\ o -> mapOrderToModel o Nothing Nothing) ords)

getOrder :: Int -> IO (Maybe OrderModel)
getOrder ordId = do
    orderRes <- get ordId
    case orderRes of
        Nothing -> return Nothing
        Just value -> do
            maybeCustomer <- get $ orderCustomerId value
            products <- ProdRep.getProductsByOrderId $ orderId value
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