{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE ConstrainedClassMethods #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Monad law, left identity" #-}
{-# HLINT ignore "Redundant <&>" #-}

module Repositories.GenericRepository.GenericRepositoryClass (GenericRepository(..)) where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Utils.Utils (maybeHead)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)
import Data.Converters.Converter
import Data.RepositoryEntity.RepositoryEntity
import Data.Functor ((<&>))

class (ReadWriteEntity a, RepositoryEntity a) => GenericRepository a where
    getList :: IO [a]
    getList =
        readEntityFields (entityString (entityName :: EntityName a)) >>=
        mapM (return . readEntity)

    get :: Int -> IO (Maybe a)
    get eid = maybeHead . filter (\a -> entityId a == eid) <$> getList

    add :: a -> IO Int
    add entity =
        ((getList :: IO [a]) <&> getUnicId) >>= \entId ->
        let newEntity = changeEntityId entity entId
            name = entityString (entityName :: EntityName a)
        in  addLine name (writeEntity newEntity) >>
        return entId

    edit :: a -> IO ()
    edit entity =
        (getList :: IO [a]) <&> getListId (entityId entity) >>= \lineId ->
        let name = entityString (entityName :: EntityName a)
        in  replaceLine name (writeEntity entity) (fromMaybe (-1) lineId)

    delete :: Int -> IO ()
    delete enId =
        (getList :: IO [a]) <&> getListId enId >>= \lineId ->
        let name = entityString (entityName :: EntityName a)
        in deleteLine name (fromMaybe (-1) lineId)

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
