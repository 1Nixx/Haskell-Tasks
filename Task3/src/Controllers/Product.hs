{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
{-# OPTIONS_GHC -Wno-unused-matches #-}
{-# OPTIONS_GHC -Wno-incomplete-uni-patterns #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Controllers.Product (getMany, getOne, add, edit, deleteE, search, handleRequest, editGet) where

import Data.Models (ProductModel (..), ShopModel (..))
import Data.Entities (Product, Shop)
import qualified Services.GenericService as S
import Services.Products (getProduct)
import Data.App (start)
import Data.SearchModels (ProductSearchModel)
import Data.AppTypes (AppResult (..), AppData (..))
import Network.Wai (Request, Response, responseLBS, requestMethod, getRequestBodyChunk)
import Data.Text (Text, unpack)
import Utils.Route (handleRoute, nextRoute)
import Network.HTTP.Types (status200, StdMethod (GET, POST), parseMethod)
import Text.Blaze.Html5 (Html)
import View.Product.Product ( getPage, getProductPage )
import Text.Blaze.Html.Renderer.Utf8 ( renderHtml )
import Data.Char (isDigit)
import Data.CommonEntity (Color(..))
import View.Product.Add (getAddPage)
import View.Product.Edit (getEditPage)
import qualified Data.List.Split as Spl
import Data.ByteString.Conversion.From (fromByteString)
import Data.Maybe (fromJust)

handleRequest :: Request -> [Text] -> IO Response
handleRequest reqest route = do
    let headRoute = handleRoute route
    case headRoute of
        "" -> responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> getMany
        "add" -> case parseMethod (requestMethod reqest) of
            Right GET -> responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> addGet
            Right POST -> do
                chunk <- getRequestBodyChunk reqest
                let prodModel = getProductModelByString $ fromJust $ fromByteString chunk
                responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> add prodModel
            _ -> return $ responseLBS status200 [("Content-Type", "text/plain")] "Not Found Product"
        "edit" -> case parseMethod (requestMethod reqest) of
            Right GET -> do
                let eid = read $ unpack $ handleRoute $ nextRoute route
                responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> editGet eid
            Right POST -> do
                chunk <- getRequestBodyChunk reqest
                let prodModel = getProductModelByString $ fromJust $ fromByteString chunk
                responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> edit prodModel
            _ -> return $ responseLBS status200 [("Content-Type", "text/plain")] "Not Found Product"
        "delete" -> case parseMethod (requestMethod reqest) of
            Right GET -> do
                let eid = read $ unpack $ handleRoute $ nextRoute route
                responseLBS status200 [("Content-Type", "text/html")] .renderHtml <$> deleteE eid
            _ -> return $ responseLBS status200 [("Content-Type", "text/plain")] "Not Found Product"
        _ -> (if all isDigit (unpack headRoute) then
                responseLBS status200 [("Content-Type", "text/html")] . renderHtml <$> getOne (read $ unpack headRoute)
            else
                return $ responseLBS status200 [("Content-Type", "text/plain")] "Not Found Product")

getMany :: IO Html
getMany = do
    let app = S.getList @Product @ProductModel
    res <- start app
    return $ getPage (appResult $ result res)

getOne :: Int -> IO Html
getOne cid = do
    let app = getProduct cid
    res <- start app
    return $ getProductPage (appResult $ result res)

addGet :: IO Html
addGet = do
    let colors = [Black, White, Other]
    let shops = S.getList @Shop @ShopModel
    res <- start shops
    return $ getAddPage (appResult $ result res) colors

add :: ProductModel -> IO Html
add model = do
    let app = S.add @Product model
    start app
    getMany

editGet :: Int -> IO Html
editGet eid = do
    let colors = [Black, White, Other]
    let shops = S.getList @Shop @ShopModel
    let prodEdit = getProduct eid
    shopsRes <- start shops
    prodRes <- start prodEdit
    return $ getEditPage (appResult $ result prodRes) (appResult $ result shopsRes) colors

edit :: ProductModel -> IO Html
edit model = do
    let app = S.edit @Product model
    start app
    getMany

deleteE :: Int -> IO Html
deleteE eid = do
    let app = S.delete @Product @ProductModel eid
    start app
    getMany

search :: ProductSearchModel -> IO (AppResult [ProductModel])
search sch =
    let app = S.search @Product sch
    in start app

getProductModelByString :: String -> ProductModel
getProductModelByString str = 
    let [v1, v2, v3, v4, v5] = map (last . Spl.splitOn "=") (Spl.splitOn "&" str)
    in ProductModel {
        productModelId = read v1,
        productModelName = v2,
        productModelPrice = read v3,
        productModelColor = read v4,
        productModelShop = Just $ ShopModel {
            shopModelId = read v5
        }
    }
