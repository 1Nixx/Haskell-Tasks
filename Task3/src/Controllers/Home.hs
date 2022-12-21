{-# LANGUAGE OverloadedStrings #-}
module Controllers.Home (index) where

import Network.Wai (Response, responseFile)
import Network.HTTP.Types (status200)

index :: IO Response
index = return $ responseFile
    status200
    [("Content-Type", "text/html")]
    "src/View/Home.html"
    Nothing