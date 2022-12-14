module Services.Shops (getShop) where

import Data.Models (ShopModel)
import Data.Entities (Shop (shopId), Product)
import qualified Services.GenericService as S
import qualified Repositories.ProductRepository as ProdRep
import Data.App (App)

getShop :: Int -> App (Maybe ShopModel)
getShop =
    S.get getProducts
    where
        getProducts :: Shop -> App (Maybe [Product])
        getProducts shop = Just <$> ProdRep.getProductsByShopId (shopId shop)