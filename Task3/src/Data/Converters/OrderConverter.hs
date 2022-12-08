{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Data.Converters.OrderConverter () where

import Data.Entities (Order(..))
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Order where 
    readEntity [x1, x2, x3] = Order {
            orderId = read x1,
            orderCustomerId = read x2,
            orderNumber = x3
        }
    writeEntity ord = show (orderId ord) ++ "|" ++ show (orderCustomerId ord) ++ "|" ++ orderNumber ord
    