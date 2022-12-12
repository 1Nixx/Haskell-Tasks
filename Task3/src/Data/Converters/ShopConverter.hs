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
    writeEntity :: Shop -> String
    writeEntity shop = show(shopId shop) ++ "|" ++ shopName shop ++ "|" ++ shopAddress shop