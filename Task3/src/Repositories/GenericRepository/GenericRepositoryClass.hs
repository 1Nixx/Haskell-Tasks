{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant <&>" #-}

module Repositories.GenericRepository.GenericRepositoryClass (GenericRepository(..)) where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Utils.Utils (maybeHead)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)
import Data.Converters.Converter
import Data.RepositoryEntity.RepositoryEntity
import Data.Functor ((<&>))
import Data.SearchModels (SearchModel(..))
import Repositories.FilterApplier (applyPagination)
import Data.App (App)

class (ReadWriteEntity a, RepositoryEntity a) => GenericRepository a where
    getList :: App [a]
    getList =
        readEntityFields (entityString (entityName :: EntityName a)) >>=
        mapM (return . readEntity)

    get :: Int -> App (Maybe a)
    get eid = maybeHead . filter (\a -> entityId a == eid) <$> getList

    add :: a -> App Int
    add entity =
        ((getList :: App [a]) <&> getUnicId) >>= \entId ->
        let newEntity = changeEntityId entity entId
            name = entityString (entityName :: EntityName a)
        in  addLine name (writeEntity newEntity) >>
        return entId

    edit :: a -> App ()
    edit entity =
        (getList :: App [a]) <&> getListId (entityId entity) >>= \lineId ->
        let name = entityString (entityName :: EntityName a)
        in  replaceLine name (writeEntity entity) (fromMaybe (-1) lineId)

    delete :: Int -> App (Maybe a)
    delete enId =
        (getList :: App [a]) <&> getListId enId >>= \lineId ->
        get enId >>= \deletedEnt -> 
        let name = entityString (entityName :: EntityName a)
        in deleteLine name (fromMaybe (-1) lineId) >>
        return deletedEnt

    search :: (SearchModel b) => (b -> [a] -> [a]) -> b -> App [a]
    search filters filterModel =
        let entities = getList :: App [a]
            pageNumber = getPageNumber filterModel
            pageSize = getPageSize filterModel
        in applyPagination pageNumber pageSize . filters filterModel <$> entities

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
