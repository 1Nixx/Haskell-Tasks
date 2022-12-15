{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# OPTIONS_GHC -Wno-partial-fields #-}

module Data.App (App(..), AppResult(..), AppConfig(..), AppState(..), AppError(..), AppLog, start) where

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

data AppResult a = AppResult { appResult :: a }
                 | AppError { message :: String }
                deriving (Show)

--type AppResult a = Either AppError a

start :: App a -> IO (AppResult a)
start app =
    let config = AppConfig "src/Files/" 5
        appstate = AppState [] [] [] [] []
        fullApp = runStateT (runReaderT (runWriterT (runExceptT (runApp app))) config) appstate
    in fullApp >>= \((resultWithErrors, logs), stateApp) -> return $ processResult resultWithErrors
    where
        processResult :: Either AppError a -> AppResult a
        processResult (Left err) = AppError $ show err
        processResult (Right res) = AppResult res

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

data AppError = ElementNotFound
              | Error
              deriving (Eq, Ord, Show)