{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-methods #-}
module Repositories.GenericRepository.ProductGenericRepository () where

import Data.Entities (Product(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository Product