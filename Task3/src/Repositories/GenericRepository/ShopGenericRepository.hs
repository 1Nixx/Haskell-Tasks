{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.ShopGenericRepository () where

import Data.Entities (Shop(..))
import Repositories.GenericRepository.GenericRepositoryClass
import Data.RepositoryEntity.RepositoryEntityClass

instance GenericRepository Shop where
    getEntity = getInstance