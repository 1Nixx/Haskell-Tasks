module Services.Products
    ( getProducts
    , getProduct) where

import Data.Models (ProductModel (ProductModel))
import qualified Repositories.Products as ProductRep
import Data.CommonEntity (Color(..))

getProducts :: [ProductModel]
getProducts = map (\ o -> ProductModel 1 Nothing "String" 445 Black) ProductRep.getProducts

getProduct :: Int -> Maybe ProductModel
getProduct prodId = Nothing