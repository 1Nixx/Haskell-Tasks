module Repositories.OrderRepository
    (getOrdersByCustomerId) where

import Data.Entities(Order(..))
import Repositories.GenericRepository.GenericRepository
import Data.AppTypes ( App ) 

getOrdersByCustomerId :: Int -> App [Order]
getOrdersByCustomerId custId = filter (\ a -> orderCustomerId a == custId) <$> getList
