module Data.SearchModels 
    ( ProductSearchModel(..)
    , ShopSearchModel(..)
    , CustomerSearchModel(..)
    , OrderSearchModel(..)) where
    
import Data.CommonEntity (Color)

data ProductSearchModel = ProductSearchModel {
    productSearchModelName :: Maybe String,
    productSearchModelPrice :: Maybe Double,
    productSearchModelColor :: Maybe Color,
    productSearchModelPage :: Int
}

data ShopSearchModel = ShopSearchModel {
    shopSearchModelName :: Maybe String,
    shopSearchModelAddress :: Maybe String,
    shopSearchModelPage :: Int
} 

data CustomerSearchModel = CustomerSearchModel {
    customerSearchModelName :: Maybe String,
    customerSearchModelAddress :: Maybe String,
    customerSearchModelPage :: Int
}

data OrderSearchModel = OrderSearchModel {
    orderSearchModelNumber :: Maybe String,
    orderSearchModelPage :: Int
}