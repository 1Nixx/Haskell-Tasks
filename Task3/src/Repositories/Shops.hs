module Repositories.Shops 
    ( getShopById
    , getShops) where

import Data.Entities (Shop(..))
import Data.Context (shops)

getShopById :: Int -> Shop
getShopById searchId = head $ filter (\a -> shopId a == searchId) shops

getShops :: [Shop]
getShops = shops
