module Services.Shops 
    ( getShops
    , getShop) where

import Data.Models (ShopModel (ShopModel))
import qualified Repositories.Shops as ShopRep

getShops :: [ShopModel]
getShops = map (\ o -> ShopModel 1 "String" "String" Nothing) ShopRep.getShops

getShop :: Int -> Maybe ShopModel
getShop shopId = Nothing