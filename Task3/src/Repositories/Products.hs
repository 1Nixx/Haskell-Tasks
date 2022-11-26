{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Repositories.Products
    ( getProductById
    , getProducts
    , getProductsByOrderId
    , getProductsByShopId
    , getProductsWithOrdersId) where

import Data.Entities (Product(..), productId, productShopId, ProductOrder (..), Order(..))
import Utils.Utils (maybeHead)
import Data.Maybe (fromJust)
import Repositories.Orders (getOrders)
import Utils.Files (readEntityFields)
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
getProductsWithOrdersId = map (\x -> (orderId x,  getProductsByOrderId $ orderId x)) <$> getOrders
