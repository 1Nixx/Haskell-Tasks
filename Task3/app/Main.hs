module Main (main) where

import qualified Services.Customer as CustomerService
import qualified Services.Orders as OrderService
import qualified Services.Products as ProductService
import qualified Services.Shops as ShopService

main :: IO ()
main = do
    putStrLn "CustomerService"
    let a = CustomerService.getCustomer 1
    print a
    putStrLn ""

    putStrLn "OrderService"
    let b = OrderService.getOrder 1
    print b
    putStrLn ""

    putStrLn "ProductService"
    let c = ProductService.getProduct 2
    print c
    putStrLn ""

    putStrLn "ShopService"
    let d = ShopService.getShop 2
    print d
    putStrLn ""