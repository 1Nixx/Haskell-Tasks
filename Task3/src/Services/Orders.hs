{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use forM_" #-}
module Services.Orders
    ( getOrders
    , getOrder
    , addOrder
    , editOrder
    , deleteOrder) where

import Data.Models (OrderModel(..))
import qualified Repositories.Orders as OrderRep
import qualified Repositories.Customers as CustRep
import qualified Repositories.Products as ProdRep
import Mappings.Mappings (mapOrderToModel, mapModelToOrder)
import Data.Entities (Order(orderCustomerId, orderId))

getOrders :: IO [OrderModel]
getOrders = do
    ords <- OrderRep.getOrders
    return (map (\ o -> mapOrderToModel o Nothing Nothing) ords)

getOrder :: Int -> IO (Maybe OrderModel)
getOrder ordId = do
    orderRes <- OrderRep.getOrderById ordId
    case orderRes of
        Nothing -> return Nothing
        Just value -> do
            maybeCustomer <- CustRep.getCustomerById $ orderCustomerId value
            products <- ProdRep.getProductsByOrderId $ orderId value
            return $ Just $ mapOrderToModel value maybeCustomer (Just products)

addOrder :: OrderModel -> IO Int
addOrder ord = 
    let order' = mapModelToOrder ord
    in OrderRep.addOrder order'

editOrder :: OrderModel -> IO ()
editOrder order = 
    let order' = mapModelToOrder order     
    in OrderRep.editOrder order'

deleteOrder :: Int -> IO ()
deleteOrder = OrderRep.deleteOrder