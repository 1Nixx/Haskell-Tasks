{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId
    , addProduct
    , editProduct
    , deleteProduct) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..), Order(..), productName, productPrice, productColor)
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust, fromMaybe)
import Repositories.Orders (getOrders)
import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Data.Converters.Converter
import Data.List (findIndex)

getProductById :: Int -> IO(Maybe Product)
getProductById searchId = do 
    prds <- getProducts
    return $ maybeHead $ filter (\a -> productId a == searchId) prds 

getProducts :: IO [Product]
getProducts = do
    productsFile <- readEntityFields "Products"
    return (map readEntity productsFile)

getProductsByOrderId :: Int -> IO [Product]
getProductsByOrderId searchOrderId = do
    productOrdersFile <- readEntityFields "ProductOrders"
    let productOrders = map readEntity productOrdersFile
    mapM (fmap fromJust . getProductById . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> IO [Product]
getProductsByShopId searchShopId = do
    prds <- getProducts
    return $ filter (\ a -> productShopId a == searchShopId) prds

getProductsWithOrdersId :: IO [(Int, [Product])]
getProductsWithOrdersId = do
    orders <- getOrders
    mapM step orders
    where
        step :: Order -> IO (Int, [Product])
        step ord = do
            let orderid = orderId ord
            products <- getProductsByOrderId orderid
            return (orderid, products)

addProduct :: Product -> IO Int
addProduct prod = do
    oldProducts <- getProducts
    let prodId = getProductUnicId oldProducts
    let newProd = Product prodId (productShopId prod) (productName prod) (productPrice prod) (productColor prod)
    addLine "Products" (writeEntity newProd)
    return prodId

getProductUnicId :: [Product] -> Int
getProductUnicId xs = productId (last xs) + 1

editProduct :: Product -> IO ()
editProduct prod = do
    oldProducts <- getProducts
    let lineId = getListId (productId prod) oldProducts 
    replaceLine "Products" (writeEntity prod) (fromMaybe (-1) lineId)
    return()

getListId :: Int -> [Product] -> Maybe Int
getListId prodId = findIndex (\x -> productId x == prodId) 

deleteProduct :: Int -> IO ()
deleteProduct prodId = do
    oldProducts <- getProducts
    let lineId = getListId prodId oldProducts 
    deleteLine "Products" (fromMaybe (-1) lineId)
    return()