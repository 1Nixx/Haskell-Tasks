{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}

module Controllers.Product (getMany, getOne, process) where

import Data.Models (ProductModel (productModelId, productModelName))
import Data.Entities (Product)
import qualified Services.GenericService as S
import Services.Products (getProduct)
import Data.App (AppResult, App, start)

getMany :: IO (AppResult [ProductModel])
getMany = 
    let app = S.getList @Product
    in start app

getOne :: Int -> IO (AppResult ProductModel)
getOne cid = 
    let app = getProduct cid
    in start app

process :: Int -> IO (AppResult ProductModel)
process cid =
    let app = processApp
    in start app
    where
        processApp :: App ProductModel
        processApp = do
            productEnt <- getProduct cid
            S.delete @Product @ProductModel (productModelId productEnt)
            added <- S.add @Product productEnt
            let editProduct = productEnt { productModelId = added, productModelName = "My test product"}
            S.edit @Product editProduct
            return editProduct