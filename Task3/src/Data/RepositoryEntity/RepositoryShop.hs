{-# OPTIONS_GHC -Wno-orphans #-}
module Data.RepositoryEntity.RepositoryShop () where

import Data.Entities (Shop(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Shop where
    entityId = shopId
    entityName = "Shops"
    changeEntityId shp newId = shp {shopId = newId}