{-# LANGUAGE OverloadedStrings #-}

module View.Order (getPage, getOrderPage) where

import Data.Models (OrderModel(..))
import Control.Monad (forM_)

import Text.Blaze.Html5 as H
    ( toHtml, a, body, docTypeHtml, head, p, table, td, th, title, tr, stringValue, Html, (!) )
import Text.Blaze.Html5.Attributes

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
                        td $ a ! href (stringValue $ "localhost:8080/Order/" ++ show (orderModelId ord)) $ "Details")

getOrderPage :: OrderModel -> Html
getOrderPage order = docTypeHtml ""
