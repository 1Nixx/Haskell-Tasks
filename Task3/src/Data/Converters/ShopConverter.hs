{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Data.Entities (Shop(..))

instance Show Shop where   
    show shop = show(shopId shop) ++ "|" ++ shopName shop ++ "|" ++ shopAddress shop

readEntity :: [String] -> Shop
readEntity [x1, x2, x3] = Shop {
        shopId = read x1,
        shopName = x2,
        shopAddress = x3
    }