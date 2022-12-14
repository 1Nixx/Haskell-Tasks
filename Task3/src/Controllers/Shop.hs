{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Controllers.Shop (getMany, getOne, process) where

import Data.Models (ShopModel (shopModelId, shopModelName))
import Data.Entities (Shop)
import qualified Services.GenericService as S
import Data.App (AppResult, App, start)
import Services.Shops (getShop)
import Data.Maybe (fromJust)

getMany :: IO (AppResult [ShopModel])
getMany = 
    let app = S.getList @Shop
    in start app

getOne :: Int -> IO (AppResult (Maybe ShopModel))
getOne cid = 
    let app = getShop cid
    in start app

process :: Int -> IO (AppResult ShopModel)
process cid =
    let app = processApp
    in start app
    where
        processApp :: App ShopModel
        processApp = do
            maybeshop <- getShop cid
            let shop = fromJust maybeshop
            S.delete @Shop @ShopModel (shopModelId shop)
            added <- S.add @Shop shop
            let editShop = shop { shopModelId = added, shopModelName = "My test shop"}
            S.edit @Shop editShop
            return editShop