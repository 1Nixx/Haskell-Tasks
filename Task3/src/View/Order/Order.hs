{-# LANGUAGE OverloadedStrings #-}

module View.Order.Order (getPage, getOrderPage) where

import Data.Models (OrderModel(..), CustomerModel (..), ProductModel (..))
import Control.Monad (forM_)

import Text.Blaze.Html5 as H
    ( toHtml, a, body, docTypeHtml, head, p, table, td, th, title, tr, stringValue, Html, (!), span, br )
import Text.Blaze.Html5.Attributes
import Data.Maybe (fromJust)

getPage :: [OrderModel] -> Html
getPage orders =
    docTypeHtml $ do
        H.head $ do
            H.title "Orders"
        body $ do
            p "Orders"
            table $ do
                tr $ do
                    th "Order Id"
                    th "Order Number"
                    th "Order details"
                forM_ orders (\ord -> do
                    tr $ do
                        td $ toHtml $ orderModelId ord
                        td $ toHtml $ orderModelNumber ord
                        td $ a ! href (stringValue $ "/Order/" ++ show (orderModelId ord)) $ "Details")

getOrderPage :: OrderModel -> Html
getOrderPage order = 
    docTypeHtml $ do
        H.head $ do
            H.title $ toHtml $ orderModelId order
        body $ do
            p "Customer"
            H.span $ toHtml ("Customer Name - " ++ customerModelName (fromJust $ orderModelCustomer order))
            br
            H.span $ toHtml ("Customer Address - " ++ customerModelAddress (fromJust $ orderModelCustomer order))
            p "Products"
            table $ do
                tr $ do
                    th "Product Id"
                    th "Product Name"
                    th "Product Price"
                    th "Product Color"
                forM_ (fromJust $ orderModelProducts order) (\prod -> do
                    tr $ do
                        td $ toHtml $ productModelId prod
                        td $ toHtml $ productModelName prod
                        td $ toHtml $ productModelPrice prod
                        td $ toHtml $ show $ productModelColor prod
                        )
                        
