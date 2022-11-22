module Services.Shops
    ( getShops
    , getShop) where

import Data.Models (ShopModel)
import Mappings.Mappings (mapShopToModel)
import qualified Repositories.Shops as ShopRep
import qualified Repositories.Products as ProdRep

getShops :: [ShopModel]
getShops = map (`mapShopToModel` Nothing) ShopRep.getShops

getShop :: Int -> Maybe ShopModel
getShop shopId = 
    let shopRes = ShopRep.getShopById shopId
    in case shopRes of
        Nothing -> Nothing
        Just value -> 
            let prodList = Just $ ProdRep.getProductsByShopId shopId
            in Just $ mapShopToModel value prodList
