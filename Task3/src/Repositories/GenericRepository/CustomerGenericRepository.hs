{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-methods #-}
module Repositories.GenericRepository.CustomerGenericRepository () where

import Data.Entities (Customer(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository Customer 
    