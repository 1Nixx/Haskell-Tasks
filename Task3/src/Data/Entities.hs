module Data.Entities 
    (Customer(..)
    , Shop(..)
    , Order(..)
    , Product(..)
    , productId
    , productShopId
    , productName
    , productPrice
    , productColor
    , ProductOrder(..)) where

import Data.CommonEntity (Color)

data Product = Product Int Int String Double Color    

productId :: Product -> Int
productId (Product prodId _ _ _ _) = prodId

productShopId :: Product -> Int
productShopId (Product _ prodShopId _ _ _) = prodShopId

productName :: Product -> String
productName (Product _ _ name _ _) = name

productPrice :: Product -> Double
productPrice (Product _ _ _ price _) = price

productColor :: Product -> Color
productColor (Product _ _ _ _ color) = color

data Customer = Customer {
    customerId :: Int,
    customerName :: String,
    customerAddress :: String
}        

data Shop = Shop {
    shopId :: Int,
    shopName :: String,
    shopAddress :: String
}

data Order = Order {
    orderId :: Int,
    orderCustomerId :: Int,
    orderNumber :: String
}

data ProductOrder = ProductOrder {
    productOrderId :: Int,
    orderFKId :: Int,
    prodFKId :: Int
}