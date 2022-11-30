{-# OPTIONS_GHC -Wno-orphans #-}
module Data.RepositoryEntity.RepositoryProductOrder () where

import Data.Entities (ProductOrder(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity ProductOrder where
    entityId = productOrderId
    entityName = "ProductOrders"
    changeEntityId prodOrd newId = prodOrd {productOrderId = newId}