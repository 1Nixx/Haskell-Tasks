{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use lambda-case" #-}
module Services.Products
    ( getProducts
    , getProduct
    , addProduct
    , editProduct
    , deleteProduct) where

import Data.Models (ProductModel)
import Data.Entities (productShopId, Product)
import Repositories.GenericRepository.GenericRepository
import Mappings.Mappings (mapProductToModel, mapModelToProduct)

getProducts :: IO [ProductModel]
getProducts = map (`mapProductToModel` Nothing) <$> getList

getProduct :: Int -> IO (Maybe ProductModel)
getProduct prodId =
    get prodId >>= getProductModel
    where
        getProductModel Nothing = return Nothing
        getProductModel (Just value) =
            let maybeShop = get (productShopId value)
            in Just . mapProductToModel value <$> maybeShop


addProduct :: ProductModel -> IO Int
addProduct prod =
    let prod' = mapModelToProduct prod
    in add prod'

editProduct :: ProductModel -> IO ()
editProduct prod =
    let prod' = mapModelToProduct prod
    in edit prod'

deleteProduct :: Int -> IO ()
deleteProduct = delete @Product