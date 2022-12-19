{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-partial-fields #-}
module Data.AppTypes (App(..), AppResult(..), AppData(..), AppCache(..), AppConfig(..), AppState(..), AppError(..), AppLog) where

import Control.Monad.IO.Class
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Data.Entities ( Customer, Order, Product, Shop, ProductOrder )
import Control.Monad.Except
import Database.MSSQLServer.Connection (Connection)

newtype App a = App {
        runApp :: ExceptT AppError (WriterT AppLog (ReaderT AppConfig (StateT AppState IO))) a
    } deriving (Functor, Applicative, Monad,
                MonadIO,
                MonadReader AppConfig,
                MonadState AppState,
                MonadWriter AppLog,
                MonadError AppError)

data AppResult a = AppResult {
    logs :: AppLog,
    state :: AppCache,
    result :: AppData a
} deriving (Show)

data AppData a = AppData { appResult :: a }
               | AppError { message :: String }
                deriving (Show)

type AppLog = [String]

data AppState = AppState {
    cache :: AppCache,
    dbConnection :: Connection
}

data AppCache = AppCache {
    customerCache :: [Customer] ,
    orderCache :: [Order],
    productCache :: [Data.Entities.Product],
    shopCache :: [Shop],
    productOrderCache :: [ProductOrder]
} deriving (Show)

data AppConfig = AppConfig {
    pageSize :: Int,
    cHost :: String,
    cPort :: String,
    cDatabase :: String,
    cUser :: String,
    cPassword :: String,
    filePath :: String
} deriving (Show)

newtype AppError = ElementNotFound String
                    deriving (Show)