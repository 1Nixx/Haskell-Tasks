{-# LANGUAGE TypeApplications #-}

module Controllers.Order (getMany, getOne, add, edit, delete, search) where

import Data.Models (OrderModel)
import Data.Entities (Order)
import qualified Services.GenericService as S
import Services.Orders (getOrder)
import Data.App (AppResult, start)
import Data.SearchModels (OrderSearchModel)

getMany :: IO (AppResult [OrderModel])
getMany = 
    let app = S.getList @Order
    in start app

getOne :: Int -> IO (AppResult OrderModel)
getOne cid = 
    let app = getOrder cid
    in start app

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