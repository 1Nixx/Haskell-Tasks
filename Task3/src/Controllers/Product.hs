{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

module Controllers.Product (getMany, getOne, add, edit, delete, search, handleRequest) where

import Data.Models (ProductModel)
import Data.Entities (Product)
import qualified Services.GenericService as S
import Services.Products (getProduct)
import Data.App (start)
import Data.SearchModels (ProductSearchModel)
import Data.AppTypes (AppResult)
import Network.Wai (Request, Response, responseLBS)
import Data.Text (Text)
import Utils.Route (handleRoute)
import Network.HTTP.Types (status200)

handleRequest :: Request -> [Text] -> Response
handleRequest reqest route = 
    case handleRoute route of
        "" -> responseLBS status200 [("Content-Type", "text/plain")] "Empty Product"
        _ -> responseLBS status200 [("Content-Type", "text/plain")] "Not Found Product"     

getMany :: IO (AppResult [ProductModel])
getMany = 
    let app = S.getList @Product
    in start app

getOne :: Int -> IO (AppResult ProductModel)
getOne cid = 
    let app = getProduct cid
    in start app

add :: ProductModel -> IO (AppResult Int)
add model = 
    let app = S.add @Product model 
    in start app

edit :: ProductModel -> IO (AppResult ())
edit model = 
    let app = S.edit @Product model
    in start app

delete :: Int -> IO (AppResult ProductModel)
delete eid = 
    let app = S.delete @Product eid
    in start app

search :: ProductSearchModel -> IO (AppResult [ProductModel])
search sch =
    let app = S.search @Product sch
    in start app