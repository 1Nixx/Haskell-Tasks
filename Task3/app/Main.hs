{-# LANGUAGE OverloadedStrings #-}
module Main (main) where

import qualified Controllers.Order as CO
import qualified Controllers.Product as CP
import qualified Controllers.Home as CH

import Network.Wai
import Network.HTTP.Types
import Network.Wai.Handler.Warp (run)
import qualified Data.ByteString.Lazy.Internal as LBS
import Utils.Route


main :: IO ()
main = do
    putStrLn "http://localhost:8080/"
    run 8080 app

app :: Application
app request respond =  (case handleRoute $ pathInfo request of
    ""     -> CH.index
    "Order" ->  CO.handleRequest request (nextRoute $ pathInfo request)
    "Product" -> CP.handleRequest request (nextRoute $ pathInfo request)
    _       -> return (responseLBS status404 [("Content-Type", "text/plain")] (LBS.packChars (show (pathInfo request))))) 
    >>= \rer -> respond rer
