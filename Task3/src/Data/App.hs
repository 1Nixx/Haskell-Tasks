{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Data.App (App(..), AppResult, start) where
import Control.Monad.IO.Class

newtype App a = Application {
        runApp :: IO a
    } deriving (Functor, Applicative, Monad, MonadIO)

type AppResult a = a

start :: App a -> IO (AppResult a)
start app = runApp app >>= \res -> return res 