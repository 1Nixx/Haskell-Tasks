{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE InstanceSigs #-}
module Data.Converters.OrderConverter () where

import Data.Entities (Order(..))
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Order where 
    readEntity :: [String] -> Order
    readEntity [x1, x2, x3] = Order {
            orderId = read x1,
            orderCustomerId = read x2,
            orderNumber = x3
        }
    insertEntityStr :: Order -> String
    insertEntityStr ord = "(" ++ show (orderId ord) ++ "," ++ show (orderCustomerId ord) ++ ",'" ++ orderNumber ord ++ "')"
    updateEntityStr :: Order -> String
    updateEntityStr ord = "OrderCustomerId = " ++ show (orderCustomerId ord) ++ ", OrderNumber = '" ++  orderNumber ord ++ "'"