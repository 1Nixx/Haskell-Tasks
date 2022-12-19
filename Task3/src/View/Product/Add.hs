{-# LANGUAGE OverloadedStrings #-}

module View.Product.Add (getAddPage) where

import Text.Blaze.Html5 as H (Html, a, body, head, title, docTypeHtml, p, table, tr, th, td, toHtml, stringValue, (!), span, br, button, form, label, input)
import Data.CommonEntity (Color)
import Data.Models (ShopModel(..))
import Text.Blaze.Html5.Attributes (method, for, name, value, type_, )

getAddPage :: [ShopModel] -> [Color] -> Html
getAddPage shops colors =
     docTypeHtml $ do
        H.head $ do
            H.title "Add Product"
        body $ do
            form ! method "POST" $ do
                label ! for "Name" $ "Enter Name : "
                input ! name "Name" ! type_ "text"
                br
                label ! for "Price" $ "Enter Price : "
                input ! name "Price" ! type_ "text"
                br
                label ! for "Price" $ "Enter Price : "
                input ! name "Price" ! type_ "text"
                br
                input ! type_ "submit" ! value "Subscribe!" 
