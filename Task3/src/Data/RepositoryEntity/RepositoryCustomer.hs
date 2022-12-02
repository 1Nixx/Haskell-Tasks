{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# LANGUAGE InstanceSigs #-}
module Data.RepositoryEntity.RepositoryCustomer () where

import Data.Entities (Customer(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..), EntityName(..))

instance RepositoryEntity Customer where
    entityId :: Customer -> Int
    entityId = customerId

    entityName :: EntityName Customer
    entityName = EntityName "Customers"
    
    changeEntityId :: Customer -> Int -> Customer
    changeEntityId cs newId = cs {customerId = newId}
  
    
