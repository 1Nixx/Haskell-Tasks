module Services.Products (getProduct) where

import Data.Models (ProductModel)
import Data.Entities (Product (productShopId), Shop)
import qualified Services.GenericService as S
import qualified Repositories.GenericRepository.GenericRepository as R
import Data.App (App)

getProduct :: Int -> App (Maybe ProductModel)
getProduct =
    S.get getShop
    where
        getShop :: Product -> App (Maybe Shop)
        getShop = R.get . productShopId
