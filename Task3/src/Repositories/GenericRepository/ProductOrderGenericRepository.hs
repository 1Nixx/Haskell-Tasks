{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-methods #-}
module Repositories.GenericRepository.ProductOrderGenericRepository () where

import Data.Entities (ProductOrder(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository ProductOrder