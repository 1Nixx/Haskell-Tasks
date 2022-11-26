{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Data.Converters.OrderConverter 
    (readEntity) where

import Data.Entities (Order(..))

instance Show Order where   
    show ord = show (orderId ord) ++ "|" ++ show (orderCustomerId ord) ++ "|" ++ orderNumber ord

readEntity :: [String] -> Order
readEntity [x1, x2, x3] = Order {
        orderId = read x1,
        orderCustomerId = read x2,
        orderNumber = x3
    }