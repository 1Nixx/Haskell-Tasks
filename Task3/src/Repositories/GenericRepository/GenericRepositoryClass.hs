{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant <&>" #-}
{-# HLINT ignore "Redundant <$>" #-}
{-# LANGUAGE TypeApplications #-}

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
import Data.App (App, AppConfig (pageSize), AppState)
import Control.Monad.Writer (MonadWriter(tell))
import Control.Monad.Reader (MonadReader(ask))
import qualified Control.Monad.State as S
import Utils.Cache

class (ReadWriteEntity a, RepositoryEntity a, CacheAccess a) => GenericRepository a where
    getList :: App [a]
    getList =
        tell ["getList: starting"] >>
        S.get >>= \state ->
        let cacheData = getCache state :: [a]
        in getData (not (null cacheData)) state cacheData >>= \result ->
        tell ["getList: completed"] >>
        return result
        where
            getData :: Bool -> AppState -> [a] -> App [a]
            getData True _ cache = return cache 
            getData False state _ = 
                (readEntityFields (entityString (entityName :: EntityName a)) >>= \fields ->
                mapM (return . readEntity) fields) >>= \arr -> 
                let newState = setCache state arr
                in S.put newState >>
                return arr
    

    get :: Int -> App (Maybe a)
    get eid =
        tell ["get: starting"] >>
        maybeHead . filter (\a -> entityId a == eid) <$> getList >>= \result ->
        tell ["get: completed"] >>
        return result

    add :: a -> App Int
    add entity =
        tell ["add: starting"] >>
        ((getList :: App [a]) <&> getUnicId) >>= \entId ->
        let newEntity = changeEntityId entity entId
            name = entityString (entityName :: EntityName a)
        in  addLine name (writeEntity newEntity) >>
        tell ["add: completed"] >>
        clearCache @a >>
        return entId

    edit :: a -> App ()
    edit entity =
        tell ["edit: starting"] >>
        (getList :: App [a]) <&> getListId (entityId entity) >>= \lineId ->
        let name = entityString (entityName :: EntityName a)
        in  replaceLine name (writeEntity entity) (fromMaybe (-1) lineId) >>
        tell ["edit: completed"] >>
        clearCache @a

    delete :: Int -> App (Maybe a)
    delete enId =
        tell ["delete: starting"] >>
        (getList :: App [a]) <&> getListId enId >>= \lineId ->
        get enId >>= \deletedEnt ->
        let name = entityString (entityName :: EntityName a)
        in deleteLine name (fromMaybe (-1) lineId) >>
        tell ["delete: completed"] >>
        clearCache @a >>
        return deletedEnt

    search :: (SearchModel b) => (b -> [a] -> [a]) -> b -> App [a]
    search filters filterModel =
        tell ["search: starting"] >>
        ask >>= \config ->
        let entities = getList :: App [a]
            pageNumber = getPageNumber filterModel
            pageSizeN = pageSize config
        in applyPagination pageNumber pageSizeN . filters filterModel <$> entities >>= \result ->
        tell ["search: completed"] >>
        return result

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
