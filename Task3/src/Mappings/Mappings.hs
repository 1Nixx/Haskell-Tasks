module Mappings.Mappings
    ( mapProductToModel
    , mapOrderToModel
    , mapCustomerToModel
    , mapShopToModel) where

import Data.Entities
    ( Product(..)
    , Shop(..)
    , Order(..)
    , productId
    , productName
    , productPrice
    , productColor
    , Customer(..))
import Data.Models (ProductModel(..), ShopModel(..), OrderModel(..), CustomerModel (..))
import Data.Maybe (fromJust)

mapProductToModel :: Product -> Maybe Shop -> ProductModel
mapProductToModel prod maybeShop =
    let shopModel = case maybeShop of
            Just value -> Just $ ShopModel {
                shopModelId = shopId value,
                shopModelName = shopName value,
                shopModelAddress = shopAddress value,
                shopModelProducts = Nothing
            }
            Nothing -> Nothing
    in ProductModel (productId prod) shopModel (productName prod) (productPrice prod) (productColor prod)

mapOrderToModel :: Order -> Maybe Customer -> Maybe [Product] -> OrderModel
mapOrderToModel ord maybeCustomer maybeProducts =
    let customerModel = case maybeCustomer of
            Just value -> Just $ mapCustomerToModel value Nothing Nothing Nothing
            Nothing -> Nothing
        productModel = case maybeProducts of
            Just value -> Just $ map (`mapProductToModel` Nothing) value
            Nothing -> Nothing
    in OrderModel {
        orderModelId = orderId ord,
        orderModelNumber = orderNumber ord,
        orderModelCustomer = customerModel,
        orderModelProducts = productModel
    }

mapCustomerToModel :: Customer -> Maybe [Order] -> Maybe [Product] -> Maybe (Product -> Int -> Bool) -> CustomerModel
mapCustomerToModel cust maybeOrders prodList selectorF =
    let orderModel = case maybeOrders of
            Just orderV -> case selectorF of
                    Just selector -> Just $ map (\o -> mapOrderToModel o Nothing (Just $ filter (\a -> selector a (orderId o)) (fromJust prodList))) orderV
                    Nothing -> Just $ map (\o -> mapOrderToModel o Nothing Nothing) orderV
            Nothing -> Nothing
    in CustomerModel {
        customerModelId = customerId cust,
        customerModelName = customerName cust,
        customerModelAddress = customerAddress cust,
        customerModelOrders = orderModel
    }

mapShopToModel :: Shop -> Maybe [Product] -> ShopModel
mapShopToModel sp maybeProduct =
    let productModelList = case maybeProduct of
            Just value -> Just $ map (`mapProductToModel` Nothing) value
            Nothing -> Nothing
    in ShopModel {
        shopModelId = shopId sp,
        shopModelName = shopName sp,
        shopModelAddress = shopAddress sp,
        shopModelProducts = productModelList
    }
