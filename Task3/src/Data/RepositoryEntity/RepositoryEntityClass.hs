{-# LANGUAGE AllowAmbiguousTypes, ScopedTypeVariables #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE ConstrainedClassMethods #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
module Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..), EntityName(..)) where

class RepositoryEntity a where
    entityId :: a -> Int
    entityName :: EntityName a
    changeEntityId :: a -> Int -> a

data EntityName a = EntityName { 
    entityString :: String
}