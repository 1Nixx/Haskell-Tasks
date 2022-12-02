{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Data.Converters.ShopConverter () where

import Data.Entities (Shop(..))
import Data.Converters.ConverterClass (ReadWriteEntity(..))

instance ReadWriteEntity Shop where
    readEntity [x1, x2, x3] = Shop {
            shopId = read x1,
            shopName = x2,
            shopAddress = x3
        }
    writeEntity shop = show(shopId shop) ++ "|" ++ shopName shop ++ "|" ++ shopAddress shop