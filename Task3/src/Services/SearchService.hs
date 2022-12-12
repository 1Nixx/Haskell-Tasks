{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE InstanceSigs #-}

module Services.SearchService (SearchService(..)) where

import Data.SearchModels (SearchModel, ProductSearchModel (..), OrderSearchModel (..), CustomerSearchModel (..), ShopSearchModel (..))
import Data.RepositoryEntity.RepositoryEntity (RepositoryEntity)
import Data.Entities (Product (..), Order (..), Customer (..), Shop (..))
import Repositories.FilterApplier (applyFilter)
import Data.List (isInfixOf)

class (SearchModel a, RepositoryEntity b) => SearchService a b where 
    searchFunc :: a -> [b] -> [b]

instance SearchService ProductSearchModel Product where
    searchFunc :: ProductSearchModel -> [Product] -> [Product]
    searchFunc filters = 
            applyFilter productName productSearchModelName isInfixOf filters
          . applyFilter productPrice productSearchModelPrice (==) filters
          . applyFilter productColor productSearchModelColor (==) filters

instance SearchService OrderSearchModel Order where
    searchFunc :: OrderSearchModel -> [Order] -> [Order]
    searchFunc = applyFilter orderNumber orderSearchModelNumber isInfixOf

instance SearchService CustomerSearchModel Customer where
    searchFunc :: CustomerSearchModel -> [Customer] -> [Customer]
    searchFunc filters =
            applyFilter customerName customerSearchModelName isInfixOf filters
          . applyFilter customerAddress customerSearchModelAddress isInfixOf filters

instance SearchService ShopSearchModel Shop where
    searchFunc :: ShopSearchModel -> [Shop] -> [Shop]
    searchFunc filters =
            applyFilter shopName shopSearchModelName isInfixOf filters
          . applyFilter shopAddress shopSearchModelAddress isInfixOf filters