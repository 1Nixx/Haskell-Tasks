{-# OPTIONS_GHC -Wno-orphans #-}
module Repositories.GenericRepository.ProductGenericRepository () where

import Data.Entities (Product(..))
import Repositories.GenericRepository.GenericRepositoryClass

instance GenericRepository Product 