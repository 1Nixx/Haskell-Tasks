{-# OPTIONS_GHC -Wno-orphans #-}
{-# OPTIONS_GHC -Wno-missing-methods #-}
module Repositories.GenericRepository.OrderGenericRepository () where

import Data.Entities (Order(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository Order