{-# LANGUAGE TypeApplications #-}
module Main (main) where

import Data.Models (CustomerModel(..), OrderModel (..), ProductModel (ProductModel), ShopModel (ShopModel))
import qualified Services.GenericService as S
import Data.Entities (Customer(Customer), Product (Product), Order(Order), Shop(Shop))
import Data.SearchModels (CustomerSearchModel(..))
import Services.Customer (getCustomer)
import Services.Orders (getOrder)
import Services.Products (getProduct)
import Services.Shops (getShop)
import Data.Maybe (fromJust)
import Data.App

main :: IO ()
main = do
    let testCust = CustomerModel {
        customerModelId = 0, 
        customerModelName = "NikitaTest",
        customerModelAddress = "GomelTest"
    }

    putStrLn "CustomerService ADD"
    custId <- runApp $ S.add @Customer testCust 
    print custId
    putStrLn ""

    let editCust = testCust {
        customerModelId = 2,
        customerModelName = "NeNikitaTest"
    }

    putStrLn "CustomerService List"
    list <- runApp $ S.getList @Order @OrderModel
    print list
    putStrLn ""

    putStrLn "CustomerService EDIT"
    runApp $ S.edit @Customer editCust

    putStrLn "CustomerService DELETE"
    res <- runApp $ S.delete @Customer @CustomerModel custId
    print res 
    putStrLn ""

    putStrLn "CustomerService"
    a <- runApp $ getCustomer 2
    print a
    putStrLn ""

    putStrLn "OrderService"
    b <- runApp $ getOrder 1
    print b
    putStrLn ""

    putStrLn "ProductService"
    c <- runApp $ getProduct 2
    print c
    putStrLn ""

    putStrLn "ShopService"
    d <- runApp $ getShop 2
    print d
    putStrLn ""

    prod1 <- runApp $ getProduct 2
    prod2 <- runApp $ getProduct 3

    cust <- runApp $ getCustomer 3

    let newOrd = OrderModel {
            orderModelId = -1,
            orderModelNumber = "tete",
            orderModelCustomer = Just $ fromJust cust,
            orderModelProducts = Just [fromJust prod1, fromJust prod2]     
        }

    putStrLn "OrderService ADD"
    ordId <- runApp $ S.add @Order newOrd
    print ordId

    putStrLn "OrderService"
    ordNew <- runApp $ getOrder ordId
    print ordNew
    putStrLn ""

    let searchModel = CustomerSearchModel {
        customerSearchModelName = Just "Nikita",
        customerSearchModelAddress = Nothing,
        customerSearchModelPage = 3
    }

    putStrLn "CustServiceSearch"
    searchRes <- runApp $ S.search @Customer @CustomerModel searchModel
    print searchRes
    putStrLn ""