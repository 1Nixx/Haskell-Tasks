module Repositories.Shops 
    ( getShopById
    , getShops
    , addShop
    , editShop
    , deleteShop) where

import Data.Entities (Shop(..))
import Utils.Utils (maybeHead)
import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Data.Converters.ShopConverter (ReadEntity(..))
import Data.List (findIndex)
import Data.Maybe (fromMaybe)

getShopById :: Int -> IO (Maybe Shop)
getShopById searchId = do 
    shps <- getShops
    return $ maybeHead $ filter (\a -> shopId a == searchId) shps

getShops :: IO [Shop]
getShops = do
    shopsFile <- readEntityFields "Shops"
    return (map readEntity shopsFile)

addShop :: Shop -> IO Int
addShop sp = do
    oldShops <- getShops
    let spId = getShopUnicId oldShops
    let newSp = sp { shopId = spId }
    addLine "Shops" (show newSp)
    return spId

getShopUnicId :: [Shop] -> Int
getShopUnicId xs = shopId (last xs) + 1  

editShop :: Shop -> IO ()
editShop sp = do
    oldShops <- getShops
    let lineId = getListId (shopId sp) oldShops 
    replaceLine "Shops" (show sp) (fromMaybe (-1) lineId)
    return()

getListId :: Int -> [Shop] -> Maybe Int
getListId spId = findIndex (\x -> shopId x == spId) 

deleteShop :: Int -> IO ()
deleteShop spId = do
    oldShops <- getShops
    let lineId = getListId spId oldShops 
    deleteLine "Shops" (fromMaybe (-1) lineId)
    return()