{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-partial-fields #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Data.App (App(..), AppResult(..), AppData(..), AppConfig(..), AppState(..), AppError(..), AppLog, start) where

import Control.Monad.IO.Class
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Data.Entities ( Customer, Order, Product, Shop, ProductOrder )
import Control.Monad.Except

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
    state :: AppState,
    result :: AppData a
} deriving (Show)

data AppData a = AppData { appResult :: a }
               | AppError { message :: String }
                deriving (Show)

start :: App a -> IO (AppResult a)
start app =
    let config = AppConfig "src/Files/" 5
        appstate = AppState [] [] [] [] []
        fullApp = runStateT (runReaderT (runWriterT (runExceptT (runApp app))) config) appstate
    in fullApp >>= \((resultWithErrors, logsApp), stateApp) -> return $ processResult resultWithErrors logsApp stateApp
    where
        processResult :: Either AppError a -> AppLog -> AppState -> AppResult a
        processResult (Left err) logsApp stateApp = AppResult logsApp stateApp (AppError (show err))
        processResult (Right res) logsApp stateApp = AppResult logsApp stateApp (AppData res)

type AppLog = [String]

data AppState = AppState {
    customerCache :: [Customer],
    orderCache :: [Order],
    productCache :: [Data.Entities.Product],
    shopCache :: [Shop],
    productOrderCache :: [ProductOrder]
} deriving (Show)

data AppConfig = AppConfig {
    filePath :: String,
    pageSize :: Int
} deriving (Show)

newtype AppError = ElementNotFound String
                    deriving (Show)