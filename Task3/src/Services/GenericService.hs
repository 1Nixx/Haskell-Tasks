{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Services.GenericService (GenericService(..)) where

import Repositories.GenericRepository.GenericRepository as R
import Mappings.Mappings (Mapping(..))
import Mappings.MappingParams (MappingParams(..))
import Services.SearchService (SearchService(..))
import Data.Entities (Customer, Order, Product, Shop)
import Data.App (App)

class  (GenericRepository a) => GenericService a where
    getList :: (Mapping b a) => App [b]
    getList = toList <$> (R.getList :: App [a])

    get :: (MappingParams b a c) => (a -> App c) -> Int -> App b
    get getParams eid = 
        (R.get eid :: App a) >>= \value -> 
        let params = getParams value
        in toModelP value <$> params

    add :: (Mapping a b) => b -> App Int
    add model =
        let model' = toModel model :: a
        in R.add model'

    edit :: (Mapping a b) => b -> App ()
    edit model =
        let model' = toModel model :: a
        in R.edit model'

    delete :: (Mapping b a) => Int -> App b
    delete eid = 
        (R.delete eid :: App a) >>= \val -> 
        return (toModel val)

    search :: (Mapping b a, SearchService c a) => c -> App [b]
    search model = toList <$> (R.search searchFunc model :: App [a])

instance GenericService Customer

instance GenericService Order

instance GenericService Product

instance GenericService Shop
