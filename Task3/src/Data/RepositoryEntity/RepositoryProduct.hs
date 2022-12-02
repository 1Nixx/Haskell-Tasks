{-# OPTIONS_GHC -Wno-missing-fields #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE InstanceSigs #-}
module Data.RepositoryEntity.RepositoryProduct () where

import Data.Entities (Product(..), productId, productShopId, productName, productPrice, productColor)
import Data.RepositoryEntity.RepositoryEntityClass (RepositoryEntity(..), EntityName (..))

instance RepositoryEntity Product where
    entityId :: Product -> Int
    entityId = productId

    entityName :: EntityName Product
    entityName = EntityName "Products"
    
    changeEntityId :: Product -> Int -> Product
    changeEntityId prod newId = Product newId (productShopId prod) (productName prod) (productPrice prod) (productColor prod)