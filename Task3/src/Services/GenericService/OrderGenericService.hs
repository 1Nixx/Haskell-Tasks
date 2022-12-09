{-# LANGUAGE MultiParamTypeClasses #-}
module Services.GenericService.OrderGenericService () where

import Services.GenericService.GenericServiceClass (GenericService(..))
import Data.Models (OrderModel)
import Data.Entities (Order)

instance GenericService Order OrderModel where