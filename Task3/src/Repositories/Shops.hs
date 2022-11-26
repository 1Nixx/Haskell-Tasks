module Repositories.Shops 
    ( getShopById
    , getShops) where

import Data.Entities (Shop(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields)
import Data.Converters.ShopConverter (readEntity)

getShopById :: Int -> IO (Maybe Shop)
getShopById searchId = do 
    maybeHead . filter (\a -> shopId a == searchId) <$> getShops

getShops :: IO [Shop]
getShops = do
    shopsFile <- readEntityFields "Shops"
    return (map readEntity shopsFile)
