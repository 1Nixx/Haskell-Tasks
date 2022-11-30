{-# OPTIONS_GHC -Wno-orphans #-}
module Data.RepositoryEntity.RepositoryCustomer () where

import Data.Entities (Customer(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Customer where
    entityId = customerId
    entityName = "Customers"
    changeEntityId cs newId = cs {customerId = newId}
