module Repositories.Shops 
    ( getShopById
    , getShops
    , addShop) where

import Data.Entities (Shop(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields, addLine)
import Data.Converters.ShopConverter (readEntity)

getShopById :: Int -> IO (Maybe Shop)
getShopById searchId = do 
    maybeHead . filter (\a -> shopId a == searchId) <$> getShops

getShops :: IO [Shop]
getShops = do
    shopsFile <- readEntityFields "Shops"
    return (map readEntity shopsFile)

addShop :: Shop -> IO Int
addShop ord = do
    oldShops <- getShops
    let spId = getShopUnicId oldShops
    let newSp = ord { shopId = spId }
    addLine "Shops" (show newSp)
    return spId

getShopUnicId :: [Shop] -> Int
getShopUnicId xs = shopId (last xs) + 1  