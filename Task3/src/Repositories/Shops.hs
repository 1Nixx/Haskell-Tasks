module Repositories.Shops 
    ( getShopById
    , getShops) where

import Data.Entities (Shop(..))
import Data.Context (shops)
import Utils.Utils (maybeHead)

getShopById :: Int -> Maybe Shop
getShopById searchId = maybeHead $ filter (\a -> shopId a == searchId) getShops

getShops :: [Shop]
getShops = shops

toWrite :: Shop -> String
toWrite shop = show(shopId shop) ++ "|" ++ shopName shop ++ "|" ++ shopAddress shop