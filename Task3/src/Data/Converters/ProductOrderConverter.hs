{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Data.Converters.ProductOrderConverter (ReadEntity(..)) where

import Data.Entities (ProductOrder(..))
import Data.Converters.Converter (ReadEntity(..))

instance Show ProductOrder where   
    show po = show(productOrderId po) ++ "|" ++ show(orderFKId po) ++ "|" ++ show(prodFKId po)

instance ReadEntity ProductOrder where 
    readEntity [x1, x2, x3] = ProductOrder {
            productOrderId = read x1,
            orderFKId = read x2,
            prodFKId = read x3
        }