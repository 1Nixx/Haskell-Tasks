{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Services.Products
    ( getProducts
    , getProduct
    , addProduct
    , editProduct
    , deleteProduct
    , searchProducts) where

import Data.Models (ProductModel)
import Data.Entities (productShopId, Product, productName, productPrice, productColor)
import Repositories.GenericRepository.GenericRepository
import Mappings.Mappings (mapProductToModel, mapModelToProduct)
import Data.SearchModels (ProductSearchModel(..))
import Repositories.FilterApplier (applyFilter)
import Data.List (isInfixOf)

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

searchProducts :: ProductSearchModel -> IO [ProductModel]
searchProducts model =
    map (`mapProductToModel` Nothing) <$> search filterFunc model 
    where
        filterFunc :: ProductSearchModel -> [Product] -> [Product]
        filterFunc filters =
            applyFilter productName productSearchModelName isInfixOf filters
          . applyFilter productPrice productSearchModelPrice (==) filters
          . applyFilter productColor productSearchModelColor (==) filters