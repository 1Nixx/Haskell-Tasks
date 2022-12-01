{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Data.RepositoryEntity.RepositoryProductOrder () where

import Data.Entities (ProductOrder(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity ProductOrder where
    entityId = productOrderId
    entityName _ = "ProductOrders"
    changeEntityId prodOrd newId = prodOrd {productOrderId = newId}
    getInstance = ProductOrder {}