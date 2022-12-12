{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Mappings.MappingParams (MappingParams(..)) where

import qualified Mappings.Mappings as M
import Data.Models (ProductModel(..), ShopModel (..), OrderModel(..), CustomerModel (..))
import Data.Entities (Product, Shop, Order (orderId), Customer)
import Utils.Utils (maybeHead)
import Data.Functor ((<&>))
import Data.Maybe (isNothing)
import Control.Applicative ((<|>))

class (M.Mapping b a) => MappingParams b a c where
    toModelP :: a -> c -> b

instance MappingParams ProductModel Product (Maybe Shop) where
    toModelP :: Product -> Maybe Shop -> ProductModel
    toModelP prod param =
        let shopModel = param <&> M.toModel
        in (M.toModel prod) {productModelShop = shopModel}

instance MappingParams OrderModel Order (Maybe Customer, Maybe [Product]) where
    toModelP :: Order -> (Maybe Customer, Maybe [Product]) -> OrderModel
    toModelP ord (param1, param2) =
        let customerModel = param1 <&> M.toModel
            productModel = param2 <&> M.toList
        in (M.toModel ord) {
            orderModelCustomer = customerModel,
            orderModelProducts = productModel
        }

instance MappingParams CustomerModel Customer (Maybe [Order], Maybe [(Int, [Product])]) where
    toModelP :: Customer -> (Maybe [Order], Maybe [(Int, [Product])]) -> CustomerModel
    toModelP cust (param1, param2) =
        let orderModel = param1 >>= \orderV ->
                (param2 >>= \dict -> return $ orderModelWithProducts dict orderV) <|> return (emptyOrderModel orderV)
        in (M.toModel cust) {customerModelOrders = orderModel}
        where
            getProductsFromDict :: Order -> [(Int, a)] -> Maybe a
            getProductsFromDict order = maybeHead . map snd . filter (\x -> fst x == orderId order)

            emptyOrderModel :: [Order] -> [OrderModel]
            emptyOrderModel = M.toList

            orderModelWithProducts :: [(Int, [Product])] -> [Order] -> [OrderModel]
            orderModelWithProducts dict = map (\o -> toModelP o (Nothing :: Maybe Customer, getProductsFromDict o dict))

instance MappingParams ShopModel Shop (Maybe [Product]) where
    toModelP :: Shop -> Maybe [Product] -> ShopModel
    toModelP sp param =
        let productModelList = param <&> M.toList
        in (M.toModel sp) {shopModelProducts = productModelList}
