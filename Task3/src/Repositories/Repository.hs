{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE InstanceSigs #-}
module Repositories.Repository where

import Utils.Files (readEntityFields, addLine, replaceLine, deleteLine)
import Data.Converters.Converter (ReadEntity(readEntity))
import Utils.Utils (maybeHead)
import Data.List (findIndex)
import Data.Maybe (fromMaybe)

class Repository a where
    getList :: IO [a]
    get :: Int -> IO (Maybe a)
    add :: a -> IO Int
    edit :: a -> IO ()
    delete :: Int -> IO ()
    idSelector :: a -> Int
    name :: String

instance Repository a where
    getList :: IO [a]
    getList = do
        fileData <- readEntityFields name
        return (map readEntity fileData)

    get :: Int -> IO (Maybe a)
    get eid = do
        allEntities <- getList
        return $ maybeHead $ filter (\a -> idSelector a == eid) allEntities

    add :: a -> IO Int
    add entity = do
        oldEntities <- getList
        let entId = getUnicId oldEntities
        -- TODO: change id
        addLine name (show entity)
        return entId

    edit ::  a -> IO ()
    edit entity = do 
        oldEntities <- getList
        let lineId = getListId (idSelector entity) oldEntities
        replaceLine name (show entity) (fromMaybe (-1) lineId)
        return()

    delete :: Int -> IO ()
    delete enId = do
        oldEntities <- getList
        let lineId = getListId enId oldEntities 
        deleteLine name (fromMaybe (-1) lineId)
        return()


getUnicId :: [a] -> Int
getUnicId xs = idSelector (last xs) + 1 

getListId :: Int -> [a] -> Maybe Int
getListId enId = findIndex (\x -> idSelector x == enId) 
     

