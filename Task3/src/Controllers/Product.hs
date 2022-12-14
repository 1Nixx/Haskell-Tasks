{-# LANGUAGE TypeApplications #-}

module Controllers.Product (getMany, getOne, process) where

import Data.Models (ProductModel (productModelId, productModelName))
import Data.Entities (Product)
import qualified Services.GenericService as S
import Services.Products (getProduct)
import Data.App (AppResult, App, start)
import Data.Maybe (fromJust)

getMany :: IO (AppResult [ProductModel])
getMany = 
    let app = S.getList @Product
    in start app

getOne :: Int -> IO (AppResult (Maybe ProductModel))
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
            maybeproduct <- getProduct cid
            let product = fromJust maybeproduct
            S.delete @Product @ProductModel (productModelId product)
            added <- S.add @Product product
            let editProduct = product { productModelId = added, productModelName = "My test product"}
            S.edit @Product editProduct
            return editProduct