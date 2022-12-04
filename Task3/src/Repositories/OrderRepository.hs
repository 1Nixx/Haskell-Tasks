module Repositories.OrderRepository
    (getOrdersByCustomerId) where

import Data.Entities(Order(..))
import Repositories.GenericRepository.GenericRepository

getOrdersByCustomerId :: Int -> IO [Order]
getOrdersByCustomerId custId = filter (\ a -> orderCustomerId a == custId) <$> getList
