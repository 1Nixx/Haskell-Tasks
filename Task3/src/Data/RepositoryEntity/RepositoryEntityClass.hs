{-# LANGUAGE AllowAmbiguousTypes #-}
module Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..)) where

class RepositoryEntity a where
    entityId :: a -> Int
    entityName :: String
    changeEntityId :: a -> Int -> a