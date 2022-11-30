{-# OPTIONS_GHC -Wno-orphans #-}
module Data.RepositoryEntity.RepositoryOrder () where

import Data.Entities (Order(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Order where
    entityId = orderId
    entityName = "Orders"
    changeEntityId ord newId = ord {orderId = newId}