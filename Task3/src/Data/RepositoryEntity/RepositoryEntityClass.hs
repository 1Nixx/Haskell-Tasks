{-# LANGUAGE AllowAmbiguousTypes, ScopedTypeVariables #-}
module Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..)) where

class RepositoryEntity a where
    entityId :: a -> Int
    entityName ::  a -> String
    changeEntityId :: a -> Int -> a
    getInstance :: a