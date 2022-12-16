module Data.Entities 
    (Customer(..)
    , Shop(..)
    , Order(..)
    , Product(..)
    , ProductOrder(..)
    ) where

import Data.CommonEntity (Color)

data Product = Product {
    productId :: Int,
    productShopId :: Int,
    productName :: String,
    productPrice :: Double,
    productColor :: Color
} deriving (Show)

data Customer = Customer {
    customerId :: Int,
    customerName :: String,
    customerAddress :: String
} deriving (Show)         

data Shop = Shop {
    shopId :: Int,
    shopName :: String,
    shopAddress :: String
} deriving (Show)

data Order = Order {
    orderId :: Int,
    orderCustomerId :: Int,
    orderNumber :: String
} deriving (Show)

data ProductOrder = ProductOrder {
    productOrderId :: Int,
    orderFKId :: Int,
    prodFKId :: Int
} deriving (Show)