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

main :: IO ()
main = do
    let testCust = CustomerModel {
        customerModelId = 0, 
        customerModelName = "NikitaTest",
        customerModelAddress = "GomelTest"
    }

    putStrLn "CustomerService ADD"
    custId <- S.add @Customer testCust 
    print custId
    putStrLn ""

    let editCust = testCust {
        customerModelId = 2,
        customerModelName = "NeNikitaTest"
    }

    putStrLn "CustomerService List"
    list <- S.getList @Order @OrderModel
    print list
    putStrLn ""

    putStrLn "CustomerService EDIT"
    S.edit @Customer editCust

    putStrLn "CustomerService DELETE"
    res <- S.delete @Customer @CustomerModel custId
    print res 
    putStrLn ""

    putStrLn "CustomerService"
    a <- getCustomer 2
    print a
    putStrLn ""

    putStrLn "OrderService"
    b <- getOrder 1
    print b
    putStrLn ""

    putStrLn "ProductService"
    c <- getProduct 2
    print c
    putStrLn ""

    putStrLn "ShopService"
    d <- getShop 2
    print d
    putStrLn ""

    prod1 <- getProduct 2
    prod2 <- getProduct 3

    cust <- getCustomer 3

    let newOrd = OrderModel {
            orderModelId = -1,
            orderModelNumber = "tete",
            orderModelCustomer = Just $ fromJust cust,
            orderModelProducts = Just [fromJust prod1, fromJust prod2]     
        }

    putStrLn "OrderService ADD"
    ordId <- S.add @Order newOrd
    print ordId

    putStrLn "OrderService"
    ordNew <- getOrder ordId
    print ordNew
    putStrLn ""

    let searchModel = CustomerSearchModel {
        customerSearchModelName = Just "Nikita",
        customerSearchModelAddress = Nothing,
        customerSearchModelPage = 3
    }

    putStrLn "CustServiceSearch"
    searchRes <- S.search @Customer @CustomerModel searchModel
    print searchRes
    putStrLn ""