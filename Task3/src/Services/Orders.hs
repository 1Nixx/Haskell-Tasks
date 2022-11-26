module Services.Orders 
    ( getOrders
    , getOrder) where
        
import Data.Models (OrderModel)
import qualified Repositories.Orders as OrderRep
import qualified Repositories.Customers as CustRep
import qualified Repositories.Products as ProdRep
import Mappings.Mappings (mapOrderToModel)
import Data.Entities (Order(orderCustomerId, orderId))

getOrders :: IO [OrderModel]
getOrders = map (\ o -> mapOrderToModel o Nothing Nothing) <$> OrderRep.getOrders

getOrder :: Int -> IO (Maybe OrderModel)
getOrder ordId = do
    orderRes <- OrderRep.getOrderById ordId
    case orderRes of 
        Nothing -> return Nothing
        Just value -> do 
            maybeCustomer <- CustRep.getCustomerById $ orderCustomerId value
            products <- ProdRep.getProductsByOrderId $ orderId value
            return $ Just $ mapOrderToModel value maybeCustomer (Just products)