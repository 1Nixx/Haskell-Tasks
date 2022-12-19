{-# LANGUAGE OverloadedStrings #-}

module View.Product.Edit (getEditPage) where

import Text.Blaze.Html5 as H (Html, a, body, head, title, docTypeHtml, p, table, tr, th, td, toHtml, stringValue, (!), span, br, button, form, label, input)
import Data.CommonEntity (Color)
import Data.Models (ShopModel(..), ProductModel (productModelName, productModelPrice, productModelId))
import Text.Blaze.Html5.Attributes (method, for, name, value, type_, )

getEditPage :: ProductModel -> [ShopModel] -> [Color] -> Html
getEditPage prod shops colors =
     docTypeHtml $ do
        H.head $ do
            H.title "Add Product"
        body $ do
            form ! method "POST" $ do
                input ! name "Id" ! type_ "hidden" ! value (stringValue $ show $ productModelId prod)
                label ! for "Name" $ "Enter Name : "
                input ! name "Name" ! type_ "text" ! value (stringValue $ productModelName prod)
                br
                label ! for "Price" $ "Enter Price : "
                input ! name "Price" ! type_ "text" ! value (stringValue $ show $ productModelPrice prod)
                br
                label ! for "Price" $ "Enter Price : "
                input ! name "Price" ! type_ "text" ! value (stringValue $ show $ productModelPrice prod)
                br
                input ! type_ "submit" ! value "Update!" 