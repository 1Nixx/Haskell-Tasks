{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.OrderGenericRepository () where

import Data.Entities (Order(..))
import Repositories.GenericRepository.GenericRepositoryClass
import Data.RepositoryEntity.RepositoryEntity

instance GenericRepository Order where
    getEntity = getInstance