{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ConstrainedClassMethods #-}

module Repositories.GenericRepository.GenericRepositoryClass (GenericRepository(..)) where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Utils.Utils (maybeHead)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)
import Data.Converters.Converter
import Data.RepositoryEntity.RepositoryEntity

class (ReadWriteEntity a, RepositoryEntity a) => GenericRepository a where
    getList :: IO [a]
    getList = do
        fileData <- readEntityFields $ entityString (entityName :: EntityName a)
        mapM (return . readEntity) fileData

    get :: Int -> IO (Maybe a)
    get eid = maybeHead . filter (\a -> entityId a == eid) <$> getList

    add :: a -> IO Int
    add entity = do
        oldEntities <- getList :: IO [a]
        let name = entityString (entityName :: EntityName a)
        let entId = getUnicId oldEntities
        let newEntity = changeEntityId entity entId
        addLine name (writeEntity newEntity)
        return entId

    edit :: a -> IO ()
    edit entity = do
        oldEntities <- getList :: IO [a]
        let name = entityString (entityName :: EntityName a)
        let lineId = getListId (entityId entity) oldEntities
        replaceLine name (writeEntity entity) (fromMaybe (-1) lineId)

    delete :: Int -> IO ()
    delete enId = do
        oldEntities <- getList :: IO [a]
        let name = entityString (entityName :: EntityName a)
        let lineId = getListId enId oldEntities
        deleteLine name (fromMaybe (-1) lineId)

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
