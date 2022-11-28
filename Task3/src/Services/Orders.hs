{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use forM_" #-}
module Services.Orders
    ( getOrders
    , getOrder
    , addOrder
    , editOrder
    , deleteOrder) where

import Data.Models (OrderModel(..), ProductModel)
import qualified Repositories.Orders as OrderRep
import qualified Repositories.Customers as CustRep
import qualified Repositories.Products as ProdRep
import Mappings.Mappings (mapOrderToModel, mapModelToOrder, mapModelToProductOrder)
import Data.Entities (Order(orderCustomerId, orderId))

getOrders :: IO [OrderModel]
getOrders = map (\ o -> mapOrderToModel o Nothing Nothing) <$> OrderRep.getOrders

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
addOrder ord = do
    let order' = mapModelToOrder ord
    ordId <- OrderRep.addOrder order'
    addProductOrders (orderModelProducts ord) ordId
    return ordId

addProductOrders :: Maybe [ProductModel] -> Int -> IO ()
addProductOrders maybePM ordId = 
    case maybePM of
        Nothing -> return()
        Just prodModel -> mapM_ (ProdRep.addProductOrder . mapModelToProductOrder ordId) prodModel

editOrder :: OrderModel -> IO ()
editOrder order = 
    let order' = mapModelToOrder order     
    in OrderRep.editOrder order'

deleteOrder :: Int -> IO ()
deleteOrder = OrderRep.deleteOrder