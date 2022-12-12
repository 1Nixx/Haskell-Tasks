module Data.Models
    (ProductModel(..)
    , ShopModel(..)
    , CustomerModel(..)
    , OrderModel(..)) where

import Data.CommonEntity (Color)

data ProductModel = ProductModel {
    productModelId :: Int,
    productModelShop :: Maybe ShopModel,
    productModelName :: String,
    productModelPrice :: Double,
    productModelColor :: Color
} deriving (Show)

data ShopModel = ShopModel {
    shopModelId :: Int,
    shopModelName :: String,
    shopModelAddress :: String,
    shopModelProducts :: Maybe [ProductModel] 
} deriving (Show)

data CustomerModel = CustomerModel {
    customerModelId :: Int,
    customerModelName :: String,
    customerModelAddress :: String,
    customerModelOrders :: Maybe [OrderModel]
} deriving (Show)

data OrderModel = OrderModel {
    orderModelId :: Int,
    orderModelNumber :: String,
    orderModelCustomer :: Maybe CustomerModel,
    orderModelProducts :: Maybe [ProductModel]
} deriving (Show)