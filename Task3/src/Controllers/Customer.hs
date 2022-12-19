{-# LANGUAGE TypeApplications #-}

module Controllers.Customer (getMany, getOne, add, edit, delete, search) where

import Data.Models (CustomerModel)
import Data.Entities (Customer)
import qualified Services.GenericService as S
import Services.Customer (getCustomer)
import Data.App (AppResult, start)
import Data.SearchModels (CustomerSearchModel)

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