{-# LANGUAGE MultiParamTypeClasses #-}
module Services.GenericService.ShopGenericService () where

import Services.GenericService.GenericServiceClass (GenericService)
import Data.Models (ShopModel)
import Data.Entities (Shop)

instance GenericService Shop ShopModel where