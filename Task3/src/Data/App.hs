{-# OPTIONS_GHC -Wno-partial-fields #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}

module Data.App (start) where

import Control.Monad.Reader
import Control.Monad.State
import Control.Monad.Writer
import Control.Monad.Except
import Utils.Database (connectToDatabase)
import Data.AppTypes
import Network.Socket (SocketType(NoSocketType))
import Database.MSSQLServer.Connection (Connection(Connection))

start :: App a -> IO (AppResult a)
start app =
    let config = AppConfig 5 "127.0.0.1" "1433" "HaskellDB" "_" "_" "src/Files/"
        appstate = AppState (AppCache [] [] [] [] []) 
        fullApp = runStateT (runReaderT (runWriterT (runExceptT (runApp app))) config) 
    -- in  connectToDatabase config >>= \conn -> 
    --     fullApp (appstate conn) >>= \((resultWithErrors, logsApp), stateApp) -> 
    --     return $ processResult resultWithErrors logsApp stateApp
    in  fullApp (appstate (Connection {})) >>= \((resultWithErrors, logsApp), stateApp) -> 
        return $ processResult resultWithErrors logsApp stateApp 
    where
        processResult :: Either AppError a -> AppLog -> AppState -> AppResult a
        processResult (Left err) logsApp stateApp = AppResult logsApp (cache stateApp) (AppError (show err))
        processResult (Right res) logsApp stateApp = AppResult logsApp (cache stateApp) (AppData res)
