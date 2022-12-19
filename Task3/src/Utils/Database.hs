{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-unused-do-bind #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# LANGUAGE InstanceSigs #-}
module Utils.Database (connectToDatabase, readAllEntities, deleteEntity, insertEntity, updateEntity) where

import qualified Data.Text as Text
import Data.AppTypes (App (..), AppConfig (..), AppState (dbConnection))
import Control.Monad.IO.Class (liftIO)

import qualified Database.MSSQLServer.Connection as MSSQL
import qualified Database.MSSQLServer.Query as MSSQL
import Database.MSSQLServer.Query.Row
import Network.Socket (withSocketsDo)
import Database.MSSQLServer.Connection
import qualified Control.Monad.State as S
import Database.Tds.Message


connectToDatabase :: AppConfig -> IO Connection
connectToDatabase config = do
    let info = defaultConnectInfo {
        connectHost = cHost config,
        connectPort = cPort config,
        connectDatabase = cDatabase config,
        connectUser = cUser config,
        connectPassword = cPassword config
    }
    withSocketsDo (MSSQL.connect info)

instance MSSQL.Row [String] where
    fromListOfRawBytes :: [MetaColumnData] -> [RawBytes] -> [String]
    fromListOfRawBytes = getArr
        where
            getArr :: [MetaColumnData] -> [RawBytes] -> [String]
            getArr (m:xt) (b:xy) = fromRawBytes (mcdTypeInfo m) b : getArr xt xy
            getArr [] [] = []

            mcdTypeInfo :: MetaColumnData -> TypeInfo
            mcdTypeInfo (MetaColumnData _ _ ti _ _) = ti

readAllEntities :: String -> App [[String]]
readAllEntities entityName = do
    state <- S.get
    let rs = MSSQL.sql (dbConnection state) $ "SELECT (*) FROM " <> Text.pack entityName
    liftIO rs

deleteEntity :: String -> Int -> App ()
deleteEntity entityName eid =
    S.get >>= \state ->
    liftIO $ (MSSQL.sql (dbConnection state) $ "DELETE " <> Text.pack entityName <> " WHERE id = " <> Text.pack (show eid) :: (IO RowCount)) >>= \(RowCount rc) ->
        print rc
insertEntity :: String -> String -> App ()
insertEntity entityName entity =
    S.get >>= \state ->
    liftIO $ (MSSQL.sql (dbConnection state) $ "INSERT INTO " <> Text.pack entityName <> " VALUES " <> Text.pack entity :: (IO RowCount)) >>= \(RowCount rc) ->
        print rc

updateEntity :: String -> String -> Int -> App ()
updateEntity entityName entity eid =
    S.get >>= \state ->
    liftIO $ (MSSQL.sql (dbConnection state) $ "UPDATE " <> Text.pack entityName <> " SET " <> Text.pack entity <> " WHERE id = " <> Text.pack (show eid)  :: (IO RowCount)) >>= \(RowCount rc) ->
        print rc
