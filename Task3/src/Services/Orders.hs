{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use forM_" #-}
{-# LANGUAGE TypeApplications #-}

module Services.Orders
    ( getOrders
    , getOrder
    , addOrder
    , editOrder
    , deleteOrder
    , searchOrders) where

import Data.Models (OrderModel)
import qualified Repositories.ProductRepository as ProdRep
import Mappings.Mappings (mapOrderToModel, mapModelToOrder)
import Data.Entities (Order(orderCustomerId, orderId, orderNumber))
import Repositories.GenericRepository.GenericRepository
import Data.SearchModels (OrderSearchModel(..))
import Repositories.FilterApplier (applyFilter)
import Data.List (isInfixOf)

getOrders :: IO [OrderModel]
getOrders = map (\ o -> mapOrderToModel o Nothing Nothing) <$> getList

getOrder :: Int -> IO (Maybe OrderModel)
getOrder ordId =
    get ordId >>= getOrderModel
    where
        getOrderModel Nothing = return Nothing
        getOrderModel (Just value) =
            let maybeCustomer = get (orderCustomerId value)
                products = ProdRep.getProductsByOrderId (orderId value)
            in (\cust prod -> Just $ mapOrderToModel value cust (Just  prod)) <$> maybeCustomer <*> products

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

searchOrders :: OrderSearchModel -> IO [OrderModel]
searchOrders model =
    map (\ o -> mapOrderToModel o Nothing Nothing) <$> search filterFunc model 
    where
        filterFunc :: OrderSearchModel -> [Order] -> [Order]
        filterFunc = applyFilter orderNumber orderSearchModelNumber isInfixOf