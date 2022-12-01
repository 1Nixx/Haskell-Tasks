{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Data.RepositoryEntity.RepositoryShop () where

import Data.Entities (Shop(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Shop where
    entityId = shopId
    entityName _ = "Shops"
    changeEntityId shp newId = shp {shopId = newId}
    getInstance = Shop {}