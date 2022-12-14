{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}

module Data.App (App(..), AppResult, AppConfig(..), AppState(..), AppLog, start, ) where

import Control.Monad.IO.Class
import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import qualified Data.Map as M
import Data.Map (empty)

newtype App a = App {
        runApp :: WriterT AppLog (ReaderT AppConfig (StateT AppState IO)) a
    } deriving (Functor, Applicative, Monad,
                MonadIO,
                MonadReader AppConfig,
                MonadState AppState,
                MonadWriter AppLog)

type AppResult a = a

start :: App a -> IO (AppResult a)
start app =
    let config = AppConfig "src/Files/" 5
        appstate = AppState empty
        fullApp = runStateT (runReaderT (runWriterT (runApp app)) config) appstate
    in fullApp >>= \((result, logs), stateApp) -> return result

type AppLog = [String]

data AppState = AppState {
    cache :: M.Map String [String]
}

data AppConfig = AppConfig {
    filePath :: String,
    pageSize :: Int
}