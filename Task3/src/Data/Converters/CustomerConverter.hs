{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Data.Converters.CustomerConverter (ReadEntity(..)) where

import Data.Entities (Customer(..))
import Data.Converters.Converter (ReadEntity(..))

instance Show Customer where   
    show cs = show (customerId cs) ++ "|" ++ customerName cs ++ "|" ++ customerAddress cs

instance ReadEntity Customer where 
    readEntity [x1, x2, x3] = Customer {
            customerId = read x1,
            customerName = x2,
            customerAddress = x3
        }
