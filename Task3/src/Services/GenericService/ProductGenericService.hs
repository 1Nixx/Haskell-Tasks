{-# LANGUAGE MultiParamTypeClasses #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module Services.GenericService.ProductGenericService () where

import Services.GenericService.GenericServiceClass (GenericService)
import Data.Models (ProductModel)
import Data.Entities (Product)

instance GenericService Product ProductModel