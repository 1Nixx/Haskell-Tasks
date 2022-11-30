{-# OPTIONS_GHC -Wno-orphans #-}
module Data.RepositoryEntity.RepositoryProduct () where

import Data.Entities (Product(..), productId, productShopId, productName, productPrice, productColor)
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Product where
    entityId = productId
    entityName = "Products"
    changeEntityId prod newId = Product newId (productShopId prod) (productName prod) (productPrice prod) (productColor prod)