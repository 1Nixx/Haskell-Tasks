{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.CustomerGenericRepository () where

import Data.Entities (Customer(..))
import Repositories.GenericRepository.GenericRepositoryClass
import Data.RepositoryEntity.RepositoryEntity

instance GenericRepository Customer where
    ofEntity = getInstance
    