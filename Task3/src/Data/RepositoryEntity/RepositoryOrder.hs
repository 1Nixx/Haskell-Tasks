{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Data.RepositoryEntity.RepositoryOrder () where

import Data.Entities (Order(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..), EntityName (..))

instance RepositoryEntity Order where
    entityId :: Order -> Int
    entityId = orderId
    
    entityName :: EntityName Order
    entityName = EntityName "Orders"

    changeEntityId :: Order -> Int -> Order
    changeEntityId ord newId = ord {orderId = newId}

    
