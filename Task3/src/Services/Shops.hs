{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use lambda-case" #-}
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
getShops = map (`mapShopToModel` Nothing) <$> getList

getShop :: Int -> IO (Maybe ShopModel)
getShop shopId =
    get shopId >>= getShopModel
    where
        getShopModel Nothing = return Nothing
        getShopModel (Just value) =
            let prodList = ProdRep.getProductsByShopId shopId
            in Just . mapShopToModel value . Just <$> prodList

addShop :: ShopModel -> IO Int
addShop shop =
    let shop' = mapModelToShop shop
    in add shop'

editShop :: ShopModel -> IO ()
editShop shop =
    let shop' = mapModelToShop shop
    in edit shop'

deleteShop :: Int -> IO ()
deleteShop = delete @Shop