module Services.Products (getProduct) where

import Data.Models (ProductModel)
import Data.Entities (Product (productShopId), Shop)
import qualified Services.GenericService as S
import qualified Repositories.GenericRepository.GenericRepository as R
import Data.App (App)

getProduct :: Int -> App ProductModel
getProduct =
    S.get getShop
    where
        getShop :: Product -> App (Maybe Shop)
        getShop prod = 
            R.get (productShopId prod) >>= \val ->
            return (Just val)
