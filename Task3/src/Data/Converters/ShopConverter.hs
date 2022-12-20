{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE InstanceSigs #-}

module Data.Converters.ShopConverter () where

import Data.Entities (Shop(..))
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Shop where
    readEntity :: [String] -> Shop
    readEntity [x1, x2, x3] = Shop {
            shopId = read x1,
            shopName = x2,
            shopAddress = x3
        }
    insertEntityStr :: Shop -> String
    insertEntityStr shop = "('" ++ shopName shop ++ "','" ++ shopAddress shop ++ "')"
    updateEntityStr :: Shop -> String
    updateEntityStr shop = "ShopName = '" ++ shopName shop ++ "', ShopAddress = '" ++ shopAddress shop ++ "'"