{-# LANGUAGE OverloadedStrings #-}
module Utils.Route (handleRoute, nextRoute) where

import Data.Text ( Text ) 
 
handleRoute :: [Text] -> Text
handleRoute (x:_) = x
handleRoute [] = ""

nextRoute :: [Text] -> [Text]
nextRoute (_:xs) = xs
nextRoute [] = [""]