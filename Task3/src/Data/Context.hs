module Data.Context 
    (customers, 
     shops, 
     orders, 
     products, 
     productOrders) where

import Data.Entities(Customer(..), Shop(..), Order(..), Product (Product), ProductOrder(..)) 
import Data.CommonEntity

customers :: [Customer]
customers = [
    Customer {
        customerId = 1,
        customerName = "Nikita",
        customerAddress = "Minsk"
    },
    Customer {
        customerId = 2,
        customerName = "Misha",
        customerAddress = "Gomel"
    },
    Customer {
        customerId = 3,
        customerName = "Andrey",
        customerAddress = "USA"
    }]

shops :: [Shop]
shops = [
    Shop {
        shopId = 1,
        shopName = "H&M",
        shopAddress = "Minsk"
    },
    Shop {
        shopId = 2,
        shopName = "Rybanok",
        shopAddress = "Vitebsk"
    },
    Shop {
        shopId = 3,
        shopName = "Malorita",
        shopAddress = "Poland"
    }]

orders :: [Order]
orders = [
    Order {
        orderId = 1,
        orderCustomerId = 2,
        orderNumber = "45AB"
    }, 
    Order {
        orderId = 2,
        orderCustomerId = 2,
        orderNumber = "555IK"
    },  
    Order {
        orderId = 3,
        orderCustomerId = 1,
        orderNumber = "741hjk"
    }]

products :: [Product]
products = [
    Product 1 2 "Molotok" 45.55 Black,
    Product 2 2 "Shayba" 789 White,
    Product 3 1 "T-Shirt" 666.66 Other]

productOrders :: [ProductOrder]
productOrders = [
    ProductOrder {
        productOrderId = 1,
        orderFKId = 1,
        prodFKId = 1
    },
    ProductOrder {
        productOrderId = 2,
        orderFKId = 1,
        prodFKId = 3
    },
    ProductOrder {
        productOrderId = 3,
        orderFKId = 3,
        prodFKId = 1
    }, 
    ProductOrder {
        productOrderId = 4,
        orderFKId = 2,
        prodFKId = 1
    }]