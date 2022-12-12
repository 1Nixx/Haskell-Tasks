{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Services.GenericService (GenericService(..)) where

import Repositories.GenericRepository.GenericRepository as R
import Mappings.Mappings (Mapping(..))
import Mappings.MappingParams (MappingParams(..))
import Services.SearchService (SearchService(..))
import Data.Entities (Customer, Order, Product, Shop)
import Utils.Utils (unwrap)

class  (GenericRepository a) => GenericService a where
    getList :: (Mapping b a) => IO [b]
    getList = toList <$> (R.getList :: IO [a])

    get :: (MappingParams b a c) => (a -> IO c) -> Int -> IO (Maybe b)
    get getParams eid = 
        unwrap $ (R.get eid :: IO (Maybe a)) >>= \maybeVal -> 
        return (maybeVal >>= \value -> 
            let params = getParams value
            in return $ Just . toModelP value <$> params)

    add :: (Mapping a b) => b -> IO Int
    add model =
        let model' = toModel model :: a
        in R.add model'

    edit :: (Mapping a b) => b -> IO ()
    edit model =
        let model' = toModel model :: a
        in R.edit model'

    delete :: (Mapping b a) => Int -> IO (Maybe b)
    delete eid = (R.delete eid :: IO (Maybe a)) >>= \maybeVal -> 
        return (maybeVal >>= \val -> return (toModel val))

    search :: (Mapping b a, SearchService c a) => c -> IO [b]
    search model = toList <$> (R.search searchFunc model :: IO [a])

instance GenericService Customer

instance GenericService Order

instance GenericService Product

instance GenericService Shop
