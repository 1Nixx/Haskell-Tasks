{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Data.Entities (Product(..), productId, productShopId, productName, productPrice, productColor)
import Data.CommonEntity (Color)

instance Show Product where   
    show pd = show (productId pd) ++ "|" ++ show (productShopId pd) ++ "|" ++ productName pd ++ "|" ++ show (productPrice pd) ++ "|" ++ show (productColor pd)

readEntity :: [String] -> Product
readEntity [x1, x2, x3, x4, x5] = Product (read x1) (read x2) x3 (read x4) (read x5::Color)