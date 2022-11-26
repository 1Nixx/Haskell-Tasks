module Services.Shops
    ( getShops
    , getShop) where

import Data.Models (ShopModel)
import Mappings.Mappings (mapShopToModel)
import qualified Repositories.Shops as ShopRep
import qualified Repositories.Products as ProdRep

getShops :: IO [ShopModel]
getShops = map (`mapShopToModel` Nothing) <$> ShopRep.getShops

getShop :: Int -> IO (Maybe ShopModel)
getShop shopId = do
    shopRes <- ShopRep.getShopById shopId
    case shopRes of
        Nothing -> return Nothing
        Just value -> do
            prodList <- ProdRep.getProductsByShopId shopId
            return $ Just $ mapShopToModel value (Just prodList)
