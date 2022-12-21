{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE InstanceSigs #-}

module Data.Converters.ProductConverter () where

import Data.Entities (Product(..))
import Data.CommonEntity (Color)
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Product where
    readEntity :: [String] -> Product
    readEntity [x1, x2, x3, x4, x5] = Product {
        productId = read x1,
        productShopId = read x2,
        productName = x3,
        productPrice = read x4,
        productColor = read x5::Color
    }
    insertEntityStr :: Product -> String
    insertEntityStr pd = "(" ++ show (productShopId pd) ++ ",'" ++ productName pd ++ "'," ++ show (productPrice pd) ++ ",'" ++ show (productColor pd) ++ "')"
    updateEntityStr :: Product -> String
    updateEntityStr pd = "ProductShopId = " ++ show (productShopId pd) ++ ", ProductName = '" ++ productName pd ++ "', ProductPrice = " ++ show (productPrice pd) ++ ", ProductColor = '" ++ show (productColor pd) ++ "'"