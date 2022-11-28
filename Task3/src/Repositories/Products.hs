{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId
    , addProduct
    , addProductOrder
    , editProduct) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..), Order(..), productName, productPrice, productColor)
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust, fromMaybe)
import Repositories.Orders (getOrders)
import Utils.Files (readEntityFields, addLine, replaceLine)
import qualified Data.Converters.ProductConverter as PC
import qualified Data.Converters.ProductOrderConverter as POC
import Data.List (findIndex)

getProductById :: Int -> IO(Maybe Product)
getProductById searchId = maybeHead . filter (\a -> productId a == searchId) <$> getProducts

getProducts :: IO [Product]
getProducts = do
    productsFile <- readEntityFields "Products"
    return (map PC.readEntity productsFile)

getProductsByOrderId :: Int -> IO [Product]
getProductsByOrderId searchOrderId = do
    productOrdersFile <- readEntityFields "ProductOrders"
    let productOrders = map POC.readEntity productOrdersFile
    mapM (fmap fromJust . getProductById . prodFKId) $ filter (\ a -> orderFKId a == searchOrderId) productOrders

getProductsByShopId :: Int -> IO [Product]
getProductsByShopId searchShopId = filter (\ a -> productShopId a == searchShopId) <$> getProducts

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
    addLine "Products" (show newProd)
    return prodId

getProductUnicId :: [Product] -> Int
getProductUnicId xs = productId (last xs) + 1

addProductOrder :: ProductOrder -> IO Int
addProductOrder po = do 
    productOrdersFile <- readEntityFields "ProductOrders"
    let productOrders = map POC.readEntity productOrdersFile
    let prodId = getPOUnicId productOrders
    let newProd = po {productOrderId = prodId}
    addLine "ProductOrders" (show newProd)
    return prodId

getPOUnicId :: [ProductOrder] -> Int
getPOUnicId xs = productOrderId (last xs) + 1

editProduct :: Product -> IO ()
editProduct prod = do
    oldProducts <- getProducts
    let lineId = getListId (productId prod) oldProducts 
    replaceLine "Products" (show prod) (fromMaybe (-1) lineId)
    return()

getListId :: Int -> [Product] -> Maybe Int
getListId prodId = findIndex (\x -> productId x == prodId) 