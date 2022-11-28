module Services.Shops
    ( getShops
    , getShop
    , addShop
    , editShop) where

import Data.Models (ShopModel)
import Mappings.Mappings (mapShopToModel, mapModelToShop)
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

addShop :: ShopModel -> IO Int
addShop shop = 
    let shop' = mapModelToShop shop     
    in ShopRep.addShop shop'

editShop :: ShopModel -> IO ()
editShop shop = 
    let shop' = mapModelToShop shop     
    in ShopRep.editShop shop'
