module Data.Context 
    (customers, 
     shops, 
     orders, 
     products, 
     productOrders) where

import Data.Entities(Customer(..), Shop(..), Order(..), Product (Product), ProductOrder(..)) 
import Data.CommonEntity

customers :: [Customer]
customers = [Customer 1 "Nikita" "Minsk", Customer 2 "Misha" "Gomel", Customer 3 "Andrey" "USA"]

shops :: [Shop]
shops = [Shop 1 "H&M" "Minsk", Shop 2 "Rybanok" "Vitebsk", Shop 3 "Malorita" "Poland"]

orders :: [Order]
orders = [Order 1 2 "45AB", Order 2 2 "555IK", Order 3 1 "741hjk"]

products :: [Product]
products = [
    Product 1 2 "Molotok" 45.55 Black,
    Product 2 2 "Shayba" 789 White,
    Product 3 1 "T-Shirt" 666.66 Other]

productOrders :: [ProductOrder]
productOrders = [
    ProductOrder 1 1 1,
    ProductOrder 2 1 3,
    ProductOrder 3 3 1, 
    ProductOrder 4 2 1]