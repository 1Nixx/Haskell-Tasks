{-# LANGUAGE MultiParamTypeClasses #-}
module Services.GenericService.ProductGenericService () where

import Services.GenericService.GenericServiceClass (GenericService)
import Data.Models (ProductModel)
import Data.Entities (Product)

instance GenericService Product ProductModel where