{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# OPTIONS_GHC -Wno-unused-matches #-}

module Controllers.Order (getMany, getOne, search, handleRequest) where

import Data.Models (OrderModel)
import Data.Entities (Order)
import qualified Services.GenericService as S
import Services.Orders (getOrder)
import Data.App (start)
import Data.SearchModels (OrderSearchModel)
import Data.AppTypes (AppResult (..), AppData (..))
import Network.Wai (Request, Response, responseLBS)
import Utils.Route (handleRoute)
import Network.HTTP.Types (status200)
import Text.Blaze.Html5 ( Html )
import Text.Blaze.Html.Renderer.Utf8 ( renderHtml )
import View.Order.Order ( getPage, getOrderPage )
import Data.Char (isDigit)
import Data.Text (unpack, Text)

handleRequest :: Request -> [Text] -> IO Response
handleRequest reqest route = do
    let headRoute = handleRoute route
    case headRoute of
        "" ->  responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> getMany
        _ -> (if all isDigit (unpack headRoute) then 
                responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> getOne (read $ unpack headRoute)
            else 
                return $ responseLBS status200 [("Content-Type", "text/plain")] "Not Found Order")

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

search :: OrderSearchModel -> IO (AppResult [OrderModel])
search sch =
    let app = S.search @Order sch
    in start app
