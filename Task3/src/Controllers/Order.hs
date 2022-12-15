{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Controllers.Order (getMany, getOne, process) where

import Data.Models (OrderModel (orderModelId, orderModelNumber))
import Data.Entities (Order)
import qualified Services.GenericService as S
import Services.Orders (getOrder)
import Data.App (AppResult, App, start)

getMany :: IO (AppResult [OrderModel])
getMany = 
    let app = S.getList @Order
    in start app

getOne :: Int -> IO (AppResult OrderModel)
getOne cid = 
    let app = getOrder cid
    in start app

process :: Int -> IO (AppResult OrderModel)
process cid =
    let app = processApp
    in start app
    where
        processApp :: App OrderModel
        processApp = do
            order <- getOrder cid
            S.delete @Order @OrderModel (orderModelId order)
            added <- S.add @Order order
            let editOrder = order { orderModelId = added, orderModelNumber = "My test order"}
            S.edit @Order editOrder
            return editOrder