{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

module Controllers.Customer (getMany, getOne, add, edit, delete, search, handleRequest) where

import Data.Models (CustomerModel)
import Data.Entities (Customer)
import qualified Services.GenericService as S
import Services.Customer (getCustomer)
import Data.App (start)
import Data.SearchModels (CustomerSearchModel)
import Data.AppTypes (AppResult)
import Network.Wai (Request, Response, responseLBS)
import Data.Text (Text)
import Utils.Route (handleRoute)
import Network.HTTP.Types (status200)

handleRequest :: Request -> [Text] -> Response
handleRequest reqest route = 
    case handleRoute route of
        "" -> responseLBS status200 [("Content-Type", "text/plain")] "Empty Customer"
        _ -> responseLBS status200 [("Content-Type", "text/plain")] "Not Found Customer"           

getMany :: IO (AppResult [CustomerModel])
getMany = 
    let app = S.getList @Customer
    in start app

getOne :: Int -> IO (AppResult CustomerModel)
getOne cid = 
    let app = getCustomer cid
    in start app

add :: CustomerModel -> IO (AppResult Int)
add model = 
    let app = S.add @Customer model 
    in start app

edit :: CustomerModel -> IO (AppResult ())
edit model = 
    let app = S.edit @Customer model
    in start app

delete :: Int -> IO (AppResult CustomerModel)
delete eid = 
    let app = S.delete @Customer eid
    in start app

search :: CustomerSearchModel -> IO (AppResult [CustomerModel])
search sch =
    let app = S.search @Customer sch
    in start app