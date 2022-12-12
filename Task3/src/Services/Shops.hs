module Services.Shops (getShop) where

import Data.Models (ShopModel)
import Data.Entities (Shop (shopId), Product)
import qualified Services.GenericService as S
import qualified Repositories.ProductRepository as ProdRep

getShop :: Int -> IO (Maybe ShopModel)
getShop =
    S.get getProducts
    where
        getProducts :: Shop -> IO (Maybe [Product])
        getProducts shop = Just <$> ProdRep.getProductsByShopId (shopId shop)