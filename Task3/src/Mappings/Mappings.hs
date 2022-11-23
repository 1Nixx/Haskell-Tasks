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
import Utils.Utils (maybeHead)

mapProductToModel :: Product -> Maybe Shop -> ProductModel
mapProductToModel prod maybeShop =
    let shopModel = case maybeShop of
            Just value -> Just $ mapShopToModel value Nothing
            Nothing -> Nothing
    in ProductModel (productId prod) shopModel (productName prod) (productPrice prod) (productColor prod)

mapOrderToModel :: Order -> Maybe Customer -> Maybe [Product] -> OrderModel
mapOrderToModel ord maybeCustomer maybeProducts =
    let customerModel = case maybeCustomer of
            Just value -> Just $ mapCustomerToModel value Nothing Nothing
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

mapCustomerToModel :: Customer -> Maybe [Order] -> Maybe [(Int, [Product])] -> CustomerModel
mapCustomerToModel cust maybeOrders prodDict =
    let orderModel = case maybeOrders of
            Just orderV -> case prodDict of
                    Just dict -> Just $ map (\o -> mapOrderToModel o Nothing (getProductsFromDict o dict)) orderV
                    Nothing -> Just $ map (\o -> mapOrderToModel o Nothing Nothing) orderV
            Nothing -> Nothing
    in CustomerModel {
        customerModelId = customerId cust,
        customerModelName = customerName cust,
        customerModelAddress = customerAddress cust,
        customerModelOrders = orderModel
    }
    where getProductsFromDict order = maybeHead . map snd . filter (\x -> fst x == orderId order)


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
