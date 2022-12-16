{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Controllers.Customer (getMany, getOne, process) where

import Data.Models (CustomerModel (customerModelId, customerModelName))
import Data.Entities (Customer)
import qualified Services.GenericService as S
import Services.Customer (getCustomer)
import Data.App (AppResult, App, start)

getMany :: IO (AppResult [CustomerModel])
getMany = 
    let app = S.getList @Customer
    in start app

getOne :: Int -> IO (AppResult CustomerModel)
getOne cid = 
    let app = getCustomer cid
    in start app

process :: Int -> IO (AppResult CustomerModel)
process cid =
    let app = processApp
    in start app
    where
        processApp :: App CustomerModel
        processApp = do
            customer <- getCustomer cid
            S.delete @Customer @CustomerModel (customerModelId customer)
            added <- S.add @Customer customer
            let editCustomer = customer { customerModelId = added, customerModelName = "My test customer"}
            S.edit @Customer editCustomer
            return editCustomer