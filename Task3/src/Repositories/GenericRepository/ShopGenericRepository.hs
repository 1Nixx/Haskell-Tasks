{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.ShopGenericRepository () where

import Data.Entities (Shop(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository Shop 