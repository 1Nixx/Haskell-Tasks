module Main (main) where

import qualified Services.Customer as CustomerService
import qualified Services.Orders as OrderService
import qualified Services.Products as ProductService
import qualified Services.Shops as ShopService

main :: IO ()
main = do
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