{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# LANGUAGE InstanceSigs #-}
module Data.RepositoryEntity.RepositoryShop () where

import Data.Entities (Shop(..))
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..), EntityName (..))

instance RepositoryEntity Shop where
    entityId :: Shop -> Int
    entityId = shopId
    
    entityName :: EntityName Shop
    entityName = EntityName  "Shops"
    
    changeEntityId :: Shop -> Int -> Shop
    changeEntityId shp newId = shp {shopId = newId}