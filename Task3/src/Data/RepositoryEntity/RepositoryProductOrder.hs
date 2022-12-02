{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# LANGUAGE InstanceSigs #-}
module Data.RepositoryEntity.RepositoryProductOrder () where

import Data.Entities (ProductOrder(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..), EntityName(..))

instance RepositoryEntity ProductOrder where
    entityId :: ProductOrder -> Int
    entityId = productOrderId

    entityName :: EntityName ProductOrder
    entityName = EntityName "ProductOrders"
    
    changeEntityId :: ProductOrder -> Int -> ProductOrder
    changeEntityId prodOrd newId = prodOrd {productOrderId = newId}