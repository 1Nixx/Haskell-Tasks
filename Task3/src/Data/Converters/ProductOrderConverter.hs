{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE InstanceSigs #-}

module Data.Converters.ProductOrderConverter () where

import Data.Entities (ProductOrder(..))
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity ProductOrder where 
    readEntity :: [String] -> ProductOrder
    readEntity [x1, x2, x3] = ProductOrder {
            productOrderId = read x1,
            orderFKId = read x2,
            prodFKId = read x3
        }
    writeEntity :: ProductOrder -> String
    writeEntity po = show(productOrderId po) ++ "|" ++ show(orderFKId po) ++ "|" ++ show(prodFKId po)