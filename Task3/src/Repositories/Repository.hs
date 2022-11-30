{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleInstances #-}
module Repositories.Repository where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Utils.Utils (maybeHead)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)
import Data.Converters.Converter
import Data.RepositoryEntity.RepositoryEntity

class (ReadWriteEntity a, RepositoryEntity a) => Repository a where
    getList :: IO [a]
    getList = do
            fileData <- readEntityFields entityName 
            return (map readEntity fileData)
    get :: Int -> IO (Maybe a)
    get eid = do
        maybeHead . filter (\a -> entityId a == eid) <$> getList

    add :: a -> IO Int
    add entity = do
        oldEntities <- getList
        let entId = getUnicId oldEntities
        let newEntity = changeEntityId entity entId
        addLine entityName (show newEntity)
        return entId

    edit :: a -> IO ()
    edit entity = do
        oldEntities <- getList
        let lineId = getListId (entityId entity) oldEntities
        replaceLine entityName (show entity) (fromMaybe (-1) lineId)
        return()

    delete :: Int -> IO ()
    delete enId = do
        oldEntities <- getList
        let lineId = getListId enId oldEntities
        let text = entityName
        deleteLine text (fromMaybe (-1) lineId)

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
