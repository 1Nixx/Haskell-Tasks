{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.ProductOrderGenericRepository () where

import Data.Entities (ProductOrder(..))
import Repositories.GenericRepository.GenericRepositoryClass
import Data.RepositoryEntity.RepositoryEntityClass

instance GenericRepository ProductOrder where
    ofEntity = getInstance