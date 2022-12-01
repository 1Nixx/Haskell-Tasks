{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleInstances #-}
module Repositories.GenericRepository.GenericRepositoryClass (GenericRepository(..)) where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Utils.Utils (maybeHead)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)
import Data.Converters.Converter
import Data.RepositoryEntity.RepositoryEntity

class (ReadWriteEntity a, RepositoryEntity a) => GenericRepository a where
    getList :: a -> IO [a]
    getList ent = do 
        fileData <- readEntityFields (entityName ent)
        return (map readEntity fileData)

    get :: a -> Int -> IO (Maybe a)
    get ent eid = do
        maybeHead . filter (\a -> entityId a == eid) <$> getList ent

    add :: a -> IO Int
    add entity = do
        oldEntities <- getList entity
        let entId = getUnicId oldEntities
        let newEntity = changeEntityId entity entId
        addLine (entityName entity) (writeEntity newEntity)
        return entId

    edit :: a -> IO ()
    edit entity = do
        oldEntities <- getList entity
        let lineId = getListId (entityId entity) oldEntities
        replaceLine (entityName entity) (writeEntity entity) (fromMaybe (-1) lineId)
        return()

    delete :: a -> Int -> IO ()
    delete ent enId = do
        oldEntities <- getList ent
        let lineId = getListId enId oldEntities
        deleteLine (entityName ent) (fromMaybe (-1) lineId)
    
    ofEntity :: a

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
