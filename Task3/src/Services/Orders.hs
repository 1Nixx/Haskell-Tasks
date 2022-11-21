module Services.Orders 
    ( getOrders
    , getOrder) where
        
import Data.Models (OrderModel (OrderModel))
import qualified Repositories.Orders as OrderRep

getOrders :: [OrderModel]
getOrders = map (\ o -> OrderModel 1 "String" Nothing Nothing) OrderRep.getOrders

getOrder :: Int -> Maybe OrderModel
getOrder ordId = Nothing