{-# LANGUAGE TypeApplications #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Services.Shops
    ( getShops
    , getShop
    , addShop
    , editShop
    , deleteShop
    , searchShops) where

import Data.Models (ShopModel)
import Mappings.Mappings (mapShopToMode)
import qualified Repositories.ProductRepository as ProdRep
import Repositories.GenericRepository.GenericRepository
import Data.Entities (Shop (shopName, shopAddress))
import Data.SearchModels (ShopSearchModel(..))
import Repositories.FilterApplier (applyFilter)
import Data.List (isInfixOf)
import Utils.Utils (unwrap)

getShops :: IO [ShopModel]
getShops = map (`mapShopToModel` Nothing) <$> getList

getShop :: Int -> IO (Maybe ShopModel)
getShop shopId =
    unwrap $ get shopId >>= \maybeShop ->
        return (maybeShop >>= \shop ->
            let prodList = ProdRep.getProductsByShopId shopId
            in return $ Just . mapShopToModel shop . Just <$> prodList)

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

searchShops :: ShopSearchModel -> IO [ShopModel]
searchShops model =
    map (`mapShopToModel` Nothing) <$> search filterFunc model
    where
        filterFunc :: ShopSearchModel -> [Shop] -> [Shop]
        filterFunc filters =
            applyFilter shopName shopSearchModelName isInfixOf filters
          . applyFilter shopAddress shopSearchModelAddress isInfixOf filters