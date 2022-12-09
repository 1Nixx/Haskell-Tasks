{-# LANGUAGE MultiParamTypeClasses #-}
module Services.GenericService.CustomerGenericService () where

import Data.Models (CustomerModel)
import Data.Entities (Customer)
import Services.GenericService.GenericServiceClass (GenericService(..))

instance GenericService Customer CustomerModel where
    