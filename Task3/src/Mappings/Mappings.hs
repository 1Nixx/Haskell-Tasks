{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE InstanceSigs #-}
module Mappings.Mappings (Mapping(..)) where

import Data.Entities (Product(..), Shop(..), Order(..), Customer(..))
import Data.Models (ProductModel(..), ShopModel(..), OrderModel(..), CustomerModel (..))
import Data.Maybe (fromMaybe)

class Mapping b a where
    toModel :: a -> b

    toList :: [a] -> [b]
    toList = map toModel

instance Mapping ProductModel Product where
    toModel :: Product -> ProductModel
    toModel prod = ProductModel {
        productModelId = productId prod,
        productModelShop = Nothing,
        productModelName = productName prod,
        productModelPrice = productPrice prod,
        productModelColor = productColor prod
    }

instance Mapping OrderModel Order where
    toModel :: Order -> OrderModel
    toModel ord = OrderModel {
        orderModelId = orderId ord,
        orderModelNumber = orderNumber ord,
        orderModelCustomer = Nothing,
        orderModelProducts = Nothing
    }

instance Mapping CustomerModel Customer where
    toModel :: Customer -> CustomerModel
    toModel cust = CustomerModel {
        customerModelId = customerId cust,
        customerModelName = customerName cust,
        customerModelAddress = customerAddress cust,
        customerModelOrders = Nothing
    }

instance Mapping ShopModel Shop where
    toModel :: Shop -> ShopModel
    toModel sp = ShopModel {
        shopModelId = shopId sp,
        shopModelName = shopName sp,
        shopModelAddress = shopAddress sp,
        shopModelProducts = Nothing
    } 

instance Mapping Product ProductModel where 
    toModel :: ProductModel -> Product
    toModel productModel =
        let spId = shopModelId <$> productModelShop productModel
        in Product {
            productId = productModelId productModel,
            productShopId = fromMaybe (-1) spId,
            productName = productModelName productModel,
            productPrice = productModelPrice productModel,
            productColor = productModelColor productModel
        }

instance Mapping Order OrderModel where
    toModel :: OrderModel -> Order
    toModel orderModel =
        let ordId = customerModelId <$> orderModelCustomer orderModel
        in Order {
            orderId = orderModelId orderModel,
            orderCustomerId = fromMaybe (-1) ordId,
            orderNumber = orderModelNumber orderModel
        }

instance Mapping Customer CustomerModel where
    toModel :: CustomerModel -> Customer
    toModel customerModel = Customer {
        customerId = customerModelId customerModel,
        customerName = customerModelName customerModel,
        customerAddress = customerModelAddress customerModel
    }

instance Mapping Shop ShopModel where
    toModel :: ShopModel -> Shop
    toModel shopModel = Shop {
        shopId = shopModelId shopModel,
        shopName = shopModelName shopModel,
        shopAddress = shopModelAddress shopModel
    }
