module Services.Orders 
    ( getOrders
    , getOrder) where
        
import Data.Models (OrderModel)
import qualified Repositories.Orders as OrderRep
import qualified Repositories.Customers as CustRep
import qualified Repositories.Products as ProdRep
import Mappings.Mappings (mapOrderToModel)
import Data.Entities (Order(orderCustomerId, orderId))

getOrders :: [OrderModel]
getOrders = map (\ o -> mapOrderToModel o Nothing Nothing) OrderRep.getOrders

getOrder :: Int -> Maybe OrderModel
getOrder ordId = 
    let orderRes = OrderRep.getOrderById ordId
    in case orderRes of 
        Nothing -> Nothing
        Just value -> 
            let maybeCustomer = CustRep.getCustomerById $ orderCustomerId value
                maybeProducts = Just $ ProdRep.getProductsByOrderId $ orderId value
            in Just $ mapOrderToModel value maybeCustomer maybeProducts