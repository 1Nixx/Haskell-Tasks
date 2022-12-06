{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE InstanceSigs #-}

module Data.SearchModels 
    ( ProductSearchModel(..)
    , ShopSearchModel(..)
    , CustomerSearchModel(..)
    , OrderSearchModel(..)
    , SearchModel(..)) where
    
import Data.CommonEntity (Color)

class SearchModel a where 
    getPageNumber :: a -> Int
    getPageCount :: a -> Int
    getPageCount _ = 5

instance SearchModel ProductSearchModel where
    getPageNumber :: ProductSearchModel -> Int
    getPageNumber = productSearchModelPage

instance SearchModel ShopSearchModel where
    getPageNumber :: ShopSearchModel -> Int
    getPageNumber = shopSearchModelPage

instance SearchModel CustomerSearchModel where
    getPageNumber :: CustomerSearchModel -> Int
    getPageNumber = customerSearchModelPage

instance SearchModel OrderSearchModel where
    getPageNumber :: OrderSearchModel -> Int
    getPageNumber = orderSearchModelPage

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