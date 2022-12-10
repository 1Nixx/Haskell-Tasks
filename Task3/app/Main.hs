{-# LANGUAGE TypeApplications #-}
module Main (main) where

import Data.Models (CustomerModel(..), OrderModel (..), ProductModel (ProductModel), ShopModel (ShopModel))
import qualified Services.GenericService as S
import Data.Entities (Customer(Customer), Product (Product), Order(Order), Shop(Shop))
import Data.SearchModels (CustomerSearchModel(..))

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

    putStrLn "CustomerService EDIT"
    S.edit @Customer editCust

    putStrLn "CustomerService DELETE"
    res <- S.delete @Customer @CustomerModel custId
    print res 
    putStrLn ""

    putStrLn "CustomerService"
    a <- S.get @Customer @CustomerModel 2
    print a
    putStrLn ""

    putStrLn "OrderService"
    b <- S.get @Order @OrderModel 1
    print b
    putStrLn ""

    putStrLn "ProductService"
    c <- S.get @Product @ProductModel 2
    print c
    putStrLn ""

    putStrLn "ShopService"
    d <- S.get @Shop @ShopModel 2
    print d
    putStrLn ""

    -- prod1 <- S.get 2
    -- prod2 <- ProductService.getProduct 3

    -- cust <- CustomerService.getCustomer 3

    -- let newOrd = OrderModel {
    --         orderModelId = -1,
    --         orderModelNumber = "tete",
    --         orderModelCustomer = Just $ fromJust cust,
    --         orderModelProducts = Just [fromJust prod1, fromJust prod2]     
    --     }

    -- putStrLn "OrderService ADD"
    -- ordId <- OrderService.addOrder newOrd
    -- print ordId

    -- putStrLn "OrderService"
    -- ordNew <- OrderService.getOrder ordId
    -- print ordNew
    -- putStrLn ""

    let searchModel = CustomerSearchModel {
        customerSearchModelName = Just "Nikita",
        customerSearchModelAddress = Nothing,
        customerSearchModelPage = 3
    }

    putStrLn "CustServiceSearch"
    searchRes <- S.search @Customer @CustomerModel searchModel
    print searchRes
    putStrLn ""