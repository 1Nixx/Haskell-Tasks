module Data.Models
    (ProductModel(..)
    , ShopModel(..)
    , CustomerModel(..)
    , OrderModel(..)
    , productModelId
    , productModelShop
    , productModelName
    , productModelPrice
    , productModelColor) where


import Data.CommonEntity (Color)


data ProductModel = ProductModel Int (Maybe ShopModel) String Double Color    

productModelId :: ProductModel -> Int
productModelId (ProductModel prodId _ _ _ _) = prodId

productModelShop :: ProductModel ->Maybe ShopModel
productModelShop (ProductModel _ prodShop _ _ _) = prodShop

productModelName :: ProductModel -> String
productModelName (ProductModel _ _ name _ _) = name

productModelPrice :: ProductModel -> Double
productModelPrice (ProductModel _ _ _ price _) = price

productModelColor :: ProductModel -> Color
productModelColor (ProductModel _ _ _ _ color) = color



data ShopModel = ShopModel {
    shopModelId :: Int,
    shopModelName :: String,
    shopModelAddress :: String,
    shopModelProducts :: Maybe [ProductModel] 
}

data CustomerModel = CustomerModel {
    customerModelId :: Int,
    customerModelName :: Int,
    customerModelAddress :: Int,
    customerModelOrders :: Maybe [OrderModel]
}

data OrderModel = OrderModel {
    orderModelId :: Int,
    orderModelNumber :: String,
    orderModelCustomer :: Maybe CustomerModel,
    orderModelProducts :: Maybe [ProductModel]
}