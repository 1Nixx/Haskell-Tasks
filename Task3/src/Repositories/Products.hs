{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId
    , addProduct) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..), Order(..), productName, productPrice, productColor)
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust)
import Repositories.Orders (getOrders)
import Utils.Files (readEntityFields, addLine)
import qualified Data.Converters.ProductConverter as PC
import qualified Data.Converters.ProductOrderConverter as POC

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