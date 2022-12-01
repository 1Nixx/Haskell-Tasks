module Repositories.OrderRepository
    (getOrdersByCustomerId) where

import Data.Entities(Order(..))
import Repositories.GenericRepository.GenericRepository

getOrdersByCustomerId :: Int -> IO [Order]
getOrdersByCustomerId custId = do
    ords <- getList (ofEntity :: Order)
    return $ filter (\ a -> orderCustomerId a == custId) ords
