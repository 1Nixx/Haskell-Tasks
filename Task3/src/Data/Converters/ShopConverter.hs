{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Data.Converters.ShopConverter (ReadEntity(..)) where

import Data.Entities (Shop(..))
import Data.Converters.Converter (ReadEntity(..))

instance Show Shop where   
    show shop = show(shopId shop) ++ "|" ++ shopName shop ++ "|" ++ shopAddress shop

instance ReadEntity Shop where
    readEntity [x1, x2, x3] = Shop {
            shopId = read x1,
            shopName = x2,
            shopAddress = x3
        }