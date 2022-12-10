{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE TypeApplications #-}

module Mappings.MappingParams (MappingParams(..)) where

import qualified Mappings.Mappings as M
import Data.Models (ProductModel(..), ShopModel (..), OrderModel(..), CustomerModel (..))
import Data.Entities (Product, Shop, Order (orderId), Customer)
import Utils.Utils (maybeHead)

class (M.Mapping b a) => MappingParams b a c where
    toModel :: a -> c -> b

instance MappingParams ProductModel Product (Maybe Shop) where
    toModel :: Product -> Maybe Shop -> ProductModel
    toModel prod param =
        let shopModel = case param of
                Just value -> Just $ M.toModel @ShopModel value
                Nothing -> Nothing
        in (M.toModel prod) {productModelShop = shopModel}

instance MappingParams OrderModel Order (Maybe Customer, Maybe [Product]) where
    toModel :: Order -> (Maybe Customer, Maybe [Product]) -> OrderModel
    toModel ord (param1, param2) =
        let customerModel = case param1 of
                Just value -> Just $ M.toModel @CustomerModel value
                Nothing -> Nothing
            productModel = case param2 of
                Just value -> Just $ map (M.toModel @ProductModel) value
                Nothing -> Nothing
        in (M.toModel ord) {
                orderModelCustomer = customerModel,
                orderModelProducts = productModel
        }

instance MappingParams CustomerModel Customer (Maybe [Order], Maybe [(Int, [Product])]) where
    toModel :: Customer -> (Maybe [Order], Maybe [(Int, [Product])]) -> CustomerModel
    toModel cust (param1, param2) =
        let orderModel = case param1 of
                Just orderV -> case param2 of
                    Just dict -> Just $ map (\o -> toModel o (Nothing :: Maybe Customer, getProductsFromDict o dict) ) orderV
                    Nothing -> Just $ map (M.toModel @OrderModel) orderV
                Nothing -> Nothing
        in (M.toModel cust) {customerModelOrders = orderModel}
        where getProductsFromDict order = maybeHead . map snd . filter (\x -> fst x == orderId order)

instance MappingParams ShopModel Shop (Maybe [Product]) where
    toModel :: Shop -> Maybe [Product] -> ShopModel
    toModel sp param =
        let productModelList = case param of
                Just value -> Just $ map M.toModel value
                Nothing -> Nothing
        in (M.toModel sp) {shopModelProducts = productModelList}
