{-# LANGUAGE TypeApplications #-}

module Controllers.Product (getMany, getOne, add, edit, delete, search) where

import Data.Models (ProductModel)
import Data.Entities (Product)
import qualified Services.GenericService as S
import Services.Products (getProduct)
import Data.App (start)
import Data.SearchModels (ProductSearchModel)
import Data.AppTypes (AppResult)

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