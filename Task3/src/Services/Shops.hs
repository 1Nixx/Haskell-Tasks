module Services.Shops
    ( getShops
    , getShop
    , addShop
    , editShop
    , deleteShop) where

import Data.Models (ShopModel)
import Mappings.Mappings (mapShopToModel, mapModelToShop)
import qualified Repositories.ProductRepository as ProdRep
import Repositories.GenericRepository.GenericRepository
import Data.Entities (Shop)

getShops :: IO [ShopModel]
getShops = do 
    sps <- getList
    return $ map (`mapShopToModel` Nothing) sps 

getShop :: Int -> IO (Maybe ShopModel)
getShop shopId = do
    shopRes <- get shopId
    case shopRes of
        Nothing -> return Nothing
        Just value -> do
            prodList <- ProdRep.getProductsByShopId shopId
            return $ Just $ mapShopToModel value (Just prodList)

addShop :: ShopModel -> IO Int
addShop shop = 
    let shop' = mapModelToShop shop     
    in add shop'

editShop :: ShopModel -> IO ()
editShop shop = 
    let shop' = mapModelToShop shop     
    in edit shop'

deleteShop :: Int -> IO ()
deleteShop = delete 