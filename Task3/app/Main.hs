module Main (main) where

import qualified Services.Products as ProductService
import qualified Services.Shops as ShopService
import qualified Services.Customer as CustomerService
import qualified Services.Orders as OrderService
import Data.Models (CustomerModel(..), OrderModel (..))
import Data.SearchModels (CustomerSearchModel(..))
import Data.Maybe (fromJust)

main :: IO ()
main = do
    let testCust = CustomerModel {
        customerModelId = 0, 
        customerModelName = "NikitaTest",
        customerModelAddress = "GomelTest"
    }

    putStrLn "CustomerService ADD"
    custId <- CustomerService.addCustomer testCust
    print custId
    putStrLn ""

    let editCust = testCust {
        customerModelId = 2,
        customerModelName = "NeNikitaTest"
    }

    putStrLn "CustomerService EDIT"
    CustomerService.editCustomer editCust

    putStrLn "CustomerService DELETE"
    CustomerService.deleteCustomer custId

    putStrLn "CustomerService"
    a <- CustomerService.getCustomer 2
    print a
    putStrLn ""

    putStrLn "OrderService"
    b <- OrderService.getOrder 1
    print b
    putStrLn ""

    putStrLn "ProductService"
    c <- ProductService.getProduct 2
    print c
    putStrLn ""

    putStrLn "ShopService"
    d <- ShopService.getShop 2
    print d
    putStrLn ""

    prod1 <- ProductService.getProduct 2
    prod2 <- ProductService.getProduct 3

    cust <- CustomerService.getCustomer 3

    let newOrd = OrderModel {
            orderModelId = -1,
            orderModelNumber = "tete",
            orderModelCustomer = Just $ fromJust cust,
            orderModelProducts = Just [fromJust prod1, fromJust prod2]     
        }

    putStrLn "OrderService ADD"
    ordId <- OrderService.addOrder newOrd
    print ordId

    putStrLn "OrderService"
    ordNew <- OrderService.getOrder ordId
    print ordNew
    putStrLn ""

    let searchModel = CustomerSearchModel {
        customerSearchModelName = Just "Nikita",
        customerSearchModelAddress = Nothing,
        customerSearchModelPage = 3
    }

    putStrLn "CustServiceSearch"
    searchRes <- CustomerService.searchCustomers searchModel
    print searchRes
    putStrLn ""