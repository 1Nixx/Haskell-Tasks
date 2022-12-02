{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-methods #-}
module Repositories.GenericRepository.ShopGenericRepository () where

import Data.Entities (Shop(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository Shop