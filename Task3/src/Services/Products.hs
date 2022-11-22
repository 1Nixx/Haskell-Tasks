module Services.Products
    ( getProducts
    , getProduct) where

import Data.Models (ProductModel)
import Data.Entities (productShopId)
import qualified Repositories.Products as ProductRep
import qualified Repositories.Shops as ShopRep
import Mappings.Mappings (mapProductToModel)

getProducts :: [ProductModel]
getProducts = map (`mapProductToModel` Nothing) ProductRep.getProducts

getProduct :: Int -> Maybe ProductModel
getProduct prodId = 
    let productRes = ProductRep.getProductById prodId
    in case productRes of 
        Nothing -> Nothing
        Just value -> 
            let maybeShop = ShopRep.getShopById $ productShopId value
            in Just $ mapProductToModel value maybeShop