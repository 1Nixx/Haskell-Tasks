{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Data.Converters.CustomerConverter 
    (readEntity) where

import Data.Entities (Customer(..))

instance Show Customer where   
    show cs = show (customerId cs) ++ "|" ++ customerName cs ++ "|" ++ customerAddress cs

readEntity :: [String] -> Customer
readEntity [x1, x2, x3] = Customer {
        customerId = read x1,
        customerName = x2,
        customerAddress = x3
    }