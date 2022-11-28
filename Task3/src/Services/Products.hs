module Services.Products
    ( getProducts
    , getProduct
    , addProduct
    , editProduct) where

import Data.Models (ProductModel)
import Data.Entities (productShopId)
import qualified Repositories.Products as ProductRep
import qualified Repositories.Shops as ShopRep
import Mappings.Mappings (mapProductToModel, mapModelToProduct)

getProducts :: IO [ProductModel]
getProducts = map (`mapProductToModel` Nothing) <$> ProductRep.getProducts

getProduct :: Int -> IO (Maybe ProductModel)
getProduct prodId = do
    productRes <- ProductRep.getProductById prodId
    case productRes of 
        Nothing -> return Nothing
        Just value -> do
            maybeShop <- ShopRep.getShopById $ productShopId value
            return $ Just $ mapProductToModel value maybeShop

addProduct :: ProductModel -> IO Int
addProduct prod = 
    let prod' = mapModelToProduct prod     
    in ProductRep.addProduct prod' 

editProduct :: ProductModel -> IO ()
editProduct prod = 
    let prod' = mapModelToProduct prod     
    in ProductRep.editProduct prod' 