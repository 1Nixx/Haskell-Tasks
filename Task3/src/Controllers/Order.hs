{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}

module Controllers.Order (getMany, getOne, add, edit, delete, search, handleRequest) where

import Data.Models (OrderModel (OrderModel))
import Data.Entities (Order)
import qualified Services.GenericService as S
import Services.Orders (getOrder)
import Data.App (start)
import Data.SearchModels (OrderSearchModel)
import Data.AppTypes (AppResult (..), AppData (..))
import Network.Wai (Request, Response, responseLBS)
import Data.Text (Text)
import Utils.Route (handleRoute, nextRoute)
import Network.HTTP.Types (status200)
import Text.Blaze.Html5 ( Html )
import Text.Blaze.Html.Renderer.Utf8
import View.Order ( getPage, getOrderPage )
import Data.Char (isDigit)
import Data.Text (unpack)

handleRequest :: Request -> [Text] -> IO Response
handleRequest reqest route = do
    case handleRoute route of
        "" ->  responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> getMany
        _ -> return $ responseLBS status200 [("Content-Type", "text/plain")] "Not Found Order"

getMany :: IO Html
getMany = do
    let app = S.getList @Order @OrderModel
    res <- start app
    return $ getPage (appResult $ result res)

getOne :: Int -> IO Html
getOne cid = do
    let app = getOrder cid
    res <- start app
    return $ getOrderPage (appResult $ result res)

add :: OrderModel -> IO (AppResult Int)
add model =
    let app = S.add @Order model
    in start app

edit :: OrderModel -> IO (AppResult ())
edit model =
    let app = S.edit @Order model
    in start app

delete :: Int -> IO (AppResult OrderModel)
delete eid =
    let app = S.delete @Order eid
    in start app

search :: OrderSearchModel -> IO (AppResult [OrderModel])
search sch =
    let app = S.search @Order sch
    in start app
