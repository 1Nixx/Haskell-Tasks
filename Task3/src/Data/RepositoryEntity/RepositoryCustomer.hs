{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Data.RepositoryEntity.RepositoryCustomer () where

import Data.Entities (Customer(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Customer where
    entityId = customerId
    entityName _ = "Customers"
    changeEntityId cs newId = cs {customerId = newId}
    getInstance = Customer {}
