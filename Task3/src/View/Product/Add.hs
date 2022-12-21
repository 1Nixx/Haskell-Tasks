{-# LANGUAGE OverloadedStrings #-}

module View.Product.Add (getAddPage) where

import Text.Blaze.Html5 as H (Html, a, body, head, title, docTypeHtml, p, table, tr, th, td, toHtml, stringValue, (!), span, br, button, form, label, input, select, option)
import Data.CommonEntity (Color)
import Data.Models (ShopModel(..))
import Text.Blaze.Html5.Attributes (method, for, name, value, type_, )
import Control.Monad (forM_)

getAddPage :: [ShopModel] -> [Color] -> Html
getAddPage shops colors =
     docTypeHtml $ do
        H.head $ do
            H.title "Add Product"
        body $ do
            form ! method "POST" $ do
                input ! name "Id" ! type_ "hidden" ! value "0"
                label ! for "Name" $ "Enter Name : "
                input ! name "Name" ! type_ "text"
                br
                label ! for "Price" $ "Enter Price : "
                input ! name "Price" ! type_ "text"
                br
                label ! for "Color" $ "Select Color : "
                select ! name "Color" $ do
                    forM_ colors (\color ->
                        option ! value (stringValue $ show color) $ toHtml (show color))
                br
                label ! for "Shop" $ "Select Shop : "
                select ! name "Shop" $ do
                    forM_ shops (\shop ->
                        option ! value (stringValue $ show $ shopModelId shop) $ toHtml (shopModelName shop)) 
                br            
                input ! type_ "submit" ! value "Add!" 
