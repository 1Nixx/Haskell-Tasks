{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE InstanceSigs #-}
module Data.Converters.CustomerConverter () where

import Data.Entities (Customer(..))
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Customer where 
    readEntity :: [String] -> Customer
    readEntity [x1, x2, x3] = Customer {
            customerId = read x1,
            customerName = x2,
            customerAddress = x3
        }
    insertEntityStr :: Customer -> String
    insertEntityStr cs = "('" ++ customerName cs ++ "','" ++ customerAddress cs ++ "')"
    updateEntityStr :: Customer -> String
    updateEntityStr cs = "CustomerName = '" ++ customerName cs ++ "', CustomerAddress = '" ++ customerAddress cs ++ "'"