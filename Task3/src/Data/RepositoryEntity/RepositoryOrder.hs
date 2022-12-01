{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Data.RepositoryEntity.RepositoryOrder () where

import Data.Entities (Order(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Order where
    entityId = orderId
    entityName _ = "Orders"
    changeEntityId ord newId = ord {orderId = newId}
