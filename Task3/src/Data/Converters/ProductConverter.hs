{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Data.Converters.ProductConverter () where

import Data.Entities (Product(..), productId, productShopId, productName, productPrice, productColor)
import Data.CommonEntity (Color)
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Product where 
    readEntity [x1, x2, x3, x4, x5] = Product (read x1) (read x2) x3 (read x4) (read x5::Color)
    writeEntity pd = show (productId pd) ++ "|" ++ show (productShopId pd) ++ "|" ++ productName pd ++ "|" ++ show (productPrice pd) ++ "|" ++ show (productColor pd)