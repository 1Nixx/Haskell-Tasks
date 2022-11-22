module Repositories.Shops 
    ( getShopById
    , getShops) where

import Data.Entities (Shop(..))
import Data.Context (shops)
import Utils.Utils (maybeHead)

getShopById :: Int -> Maybe Shop
getShopById searchId = maybeHead $ filter (\a -> shopId a == searchId) shops

getShops :: [Shop]
getShops = shops
