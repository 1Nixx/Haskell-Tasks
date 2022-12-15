{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

module Data.App (App(..), AppResult(..), AppConfig(..), AppState(..), AppLog, start, ) where

import Control.Monad.IO.Class
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Data.Entities ( Customer, Order, Product, Shop, ProductOrder )

newtype App a = App {
        runApp :: WriterT AppLog (ReaderT AppConfig (StateT AppState IO)) a
    } deriving (Functor, Applicative, Monad,
                MonadIO,
                MonadReader AppConfig,
                MonadState AppState,
                MonadWriter AppLog)

--data AppResult a = AppResult { appResult :: Maybe a }

type AppResult a = a

start :: App a -> IO (AppResult a)
start app =
    let config = AppConfig "src/Files/" 5
        appstate = AppState [] [] [] [] []
        fullApp = runStateT (runReaderT (runWriterT (runApp app)) config) appstate
    in fullApp >>= \((result, logs), stateApp) -> return result

type AppLog = [String]

data AppState = AppState {
    customerCache :: [Customer],
    orderCache :: [Order],
    productCache :: [Data.Entities.Product],
    shopCache :: [Shop],
    productOrderCache :: [ProductOrder]
}

data AppConfig = AppConfig {
    filePath :: String,
    pageSize :: Int
}