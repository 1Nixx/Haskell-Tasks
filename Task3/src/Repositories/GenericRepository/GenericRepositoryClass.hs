{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Redundant <&>" #-}
{-# HLINT ignore "Redundant <$>" #-}
{-# LANGUAGE TypeApplications #-}
{-# HLINT ignore "Use >=>" #-}

module Repositories.GenericRepository.GenericRepositoryClass (GenericRepository(..)) where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Data.List (findIndex)
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
import Utils.Utils (validateArr, validateMaybe)

class (ReadWriteEntity a, RepositoryEntity a, CacheAccess a) => GenericRepository a where
    getList :: App [a]
    getList =
        let entName = entityString (entityName :: EntityName a)
        in tell [entName ++ " getList - starting"] >>
        S.get >>= \state ->
        let cacheData = getCache state :: [a]
        in getData (not (null cacheData)) state cacheData entName >>= \result ->
        tell [entName ++ " getList - completed"] >>
        return result
        where
            getData :: Bool -> AppState -> [a] -> String -> App [a]
            getData True _ cache _ = return cache
            getData False state _ entName =
                (readEntityFields entName >>= \fields ->
                mapM (return . readEntity) fields) >>= \arr ->
                let newState = setCache state arr
                in S.put newState >>
                return arr

    get :: Int -> App a
    get eid =
        let entName = entityString (entityName :: EntityName a)
        in tell [entName ++ " get id: " ++ show eid ++ " - starting"] >>
        filter (\a -> entityId a == eid) <$> getList >>= \entityArr ->
        validateArr eid entName entityArr >>= \result ->
        tell [entName ++ " get id: " ++ show eid ++ " - completed"] >>
        return result

    add :: a -> App Int
    add entity =
        let entName = entityString (entityName :: EntityName a)
        in tell [entName ++ " add new - starting"] >>
        ((getList :: App [a]) <&> getUnicId) >>= \entId ->
        let newEntity = changeEntityId entity entId
        in  addLine entName (writeEntity newEntity) >>
        tell [entName ++ "add new id: " ++ show entId ++ " - completed"] >>
        clearCache @a >>
        return entId

    edit :: a -> App ()
    edit entity =
        let entName = entityString (entityName :: EntityName a)
            eid = entityId entity
        in tell [entName ++ " edit id: " ++ show eid ++ " - starting"] >>
        (getList :: App [a]) <&> getListId eid >>= \maybeLineId ->
        validateMaybe eid entName maybeLineId >>= \lineId ->
        replaceLine entName (writeEntity entity) lineId >>
        tell [entName ++ " edit id: " ++ show eid ++ " - completed"] >>
        clearCache @a

    delete :: Int -> App a
    delete enId =
        let entName = entityString (entityName :: EntityName a)
        in tell [entName ++ " delete id: " ++ show enId ++" - starting"] >>
        (getList :: App [a]) <&> getListId enId >>= \maybeLineId ->
        validateMaybe enId entName maybeLineId >>= \lineId ->
        get enId >>= \deletedEnt ->
        deleteLine entName lineId >>
        tell [entName ++ " delete id: " ++ show enId ++ " - completed"] >>
        clearCache @a >>
        return deletedEnt

    search :: (SearchModel b) => (b -> [a] -> [a]) -> b -> App [a]
    search filters filterModel =
        let entName = entityString (entityName :: EntityName a)
        in tell [entName ++ " search - starting"] >>
        ask >>= \config ->
        let entities = getList :: App [a]
            pageNumber = getPageNumber filterModel
            pageSizeN = pageSize config
        in applyPagination pageNumber pageSizeN . filters filterModel <$> entities >>= \result ->
        tell [entName ++ " search - completed"] >>
        return result

getUnicId :: (RepositoryEntity a) => [a] -> Int
getUnicId xs = entityId (last xs) + 1

getListId :: (RepositoryEntity a) => Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> entityId x == enId)
