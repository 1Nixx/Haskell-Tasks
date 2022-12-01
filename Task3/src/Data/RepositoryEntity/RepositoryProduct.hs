{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-fields #-}
module Data.RepositoryEntity.RepositoryProduct () where

import Data.Entities (Product(..), productId, productShopId, productName, productPrice, productColor)
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..))

instance RepositoryEntity Product where
    entityId = productId
    entityName _ = "Products"
    changeEntityId prod newId = Product newId (productShopId prod) (productName prod) (productPrice prod) (productColor prod)
    getInstance = Product {}