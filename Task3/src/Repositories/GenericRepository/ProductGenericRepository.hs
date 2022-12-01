{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.ProductGenericRepository () where

import Data.Entities (Product(..))
import Repositories.GenericRepository.GenericRepositoryClass
import Data.RepositoryEntity.RepositoryEntityClass

instance GenericRepository Product where
    getEntity = getInstance