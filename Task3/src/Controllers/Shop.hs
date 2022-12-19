{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}
{-# LANGUAGE OverloadedStrings #-}

module Controllers.Shop (getMany, getOne, add, edit, delete, search, handleRequest) where

import Data.Models (ShopModel)
import Data.Entities (Shop)
import qualified Services.GenericService as S
import Data.App (start)
import Services.Shops (getShop)
import Data.SearchModels
import Data.AppTypes (AppResult)
import Network.Wai (Request, Response, responseLBS)
import Data.Text (Text)
import Utils.Route (handleRoute)
import Network.HTTP.Types (status200)

handleRequest :: Request -> [Text] -> Response
handleRequest reqest route = 
    case handleRoute route of
        "" -> responseLBS status200 [("Content-Type", "text/plain")] "Empty"
        _ -> responseLBS status200 [("Content-Type", "text/plain")] "Not Found Customer"     

getMany :: IO (AppResult [ShopModel])
getMany = 
    let app = S.getList @Shop
    in start app

getOne :: Int -> IO (AppResult ShopModel)
getOne cid = 
    let app = getShop cid
    in start app

add :: ShopModel -> IO (AppResult Int)
add model = 
    let app = S.add @Shop model 
    in start app

edit :: ShopModel -> IO (AppResult ())
edit model = 
    let app = S.edit @Shop model
    in start app

delete :: Int -> IO (AppResult ShopModel)
delete eid = 
    let app = S.delete @Shop eid
    in start app

search :: ShopSearchModel -> IO (AppResult [ShopModel])
search sch =
    let app = S.search @Shop sch
    in start app