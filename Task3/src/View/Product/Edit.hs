{-# LANGUAGE OverloadedStrings #-}

module View.Product.Edit (getEditPage) where

import Text.Blaze.Html5 as H (Html, a, body, head, title, docTypeHtml, p, table, tr, th, td, toHtml, stringValue, (!), span, br, button, form, label, input, select, option)
import Data.CommonEntity (Color)
import Data.Models (ShopModel(..), ProductModel (..))
import Text.Blaze.Html5.Attributes (method, for, name, value, type_, selected, )
import Control.Monad (forM_)
import Data.Maybe (fromJust)

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
                label ! for "Color" $ "Select Color : "
                select ! name "Color" $ do
                    forM_ colors (\color ->
                        if productModelColor prod == color  then
                            option ! value (stringValue $ show color) ! selected "selected" $ toHtml (show color)
                        else
                            option ! value (stringValue $ show color) $ toHtml (show color)
                        )
                br
                label ! for "Shop" $ "Select Shop : "
                select ! name "Shop" $ do
                    forM_ shops (\shop ->
                        if shopModelId (fromJust $ productModelShop prod) == shopModelId shop  then
                            option ! value (stringValue $ show $ shopModelId shop) ! selected "selected" $ toHtml (shopModelName shop)
                        else
                            option ! value (stringValue $ show $ shopModelId shop) $ toHtml (shopModelName shop)
                        )
                br
                input ! type_ "submit" ! value "Update!"