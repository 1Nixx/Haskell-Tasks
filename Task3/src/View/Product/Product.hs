{-# LANGUAGE OverloadedStrings #-}
module View.Product.Product (getPage, getProductPage) where

import Text.Blaze.Html5 as H (Html, a, body, head, title, docTypeHtml, p, table, tr, th, td, toHtml, stringValue, (!), span, br, button)
import Data.Models (ProductModel(..), ShopModel (shopModelName, shopModelAddress))
import Control.Monad (forM_)
import Text.Blaze.Html5.Attributes (href)
import Data.Maybe (fromJust)

getPage :: [ProductModel] -> Html
getPage products = 
    docTypeHtml $ do
        H.head $ do
            H.title "Products"
        body $ do 
            p "Products"
            table $ do 
                tr $ do
                    th "Product Id"
                    th "Product Name"
                    th "Product Price"
                    th "Product Color"
                    th "Product Details"
                forM_ products (\prod -> do
                    tr $ do 
                        td $ toHtml $ productModelId prod
                        td $ toHtml $ productModelName prod
                        td $ toHtml $ productModelPrice prod
                        td $ toHtml $ show $ productModelColor prod
                        td $ a ! href (stringValue $ "/Product/" ++ show (productModelId prod)) $ "Details")
            button $ a ! href "/Product/add" $ "Add product"
                        
getProductPage :: ProductModel -> Html
getProductPage prod =
    docTypeHtml $ do
        H.head $ do
            H.title "Product"
        body $ do 
            p "Shop Info"
            H.span $ toHtml ("Shop Name - " ++ shopModelName (fromJust $ productModelShop prod))
            br
            H.span $ toHtml ("Shop Address - " ++ shopModelAddress (fromJust $ productModelShop prod))
            br
            p "Product Info"
            H.span $ toHtml ("Product Name - " ++ productModelName prod)
            br
            H.span $ toHtml ("Product Price - " ++ show (productModelPrice prod))
            br
            H.span $ toHtml ("Product Color - " ++ show (productModelColor prod))
            br
            button $ a ! href (stringValue $ "/Product/edit/" ++ show (productModelId prod)) $ "Edit product"