{-# LANGUAGE TypeApplications #-}
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
getProducts = do
    prds <- getList
    return $ map (`mapProductToModel` Nothing) prds 

getProduct :: Int -> IO (Maybe ProductModel)
getProduct prodId = do
    productRes <- get prodId
    case productRes of 
        Nothing -> return Nothing
        Just value -> do
            maybeShop <- get $ productShopId value
            return $ Just $ mapProductToModel value maybeShop

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