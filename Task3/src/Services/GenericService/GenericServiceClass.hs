{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Services.GenericService.GenericServiceClass (GenericService(..)) where

import Repositories.GenericRepository.GenericRepository as R
import Mappings.Mappings (Mapping(..))
import Services.SearchService (SearchService(..))
import Data.ServiceEntity.ServiceEntity

class  (GenericRepository a, ServiceEntity b) => GenericService a b where
    getList :: (Mapping b a) => IO [b]
    getList = toList <$> (R.getList :: IO [a])

    get :: (Mapping b a) => Int -> IO (Maybe b)
    get eid = (R.get eid :: IO (Maybe a)) >>= \maybeVal -> 
        return (maybeVal >>= \val -> return(toModel val) )

    add :: (Mapping a b) => b -> IO Int
    add model =
        let model' = toModel model :: a
        in R.add model'

    edit :: (Mapping a b) => b -> IO ()
    edit model =
        let model' = toModel model :: a
        in R.edit model'

    delete :: Int -> IO ()
    delete = R.delete @a

    search :: (Mapping b a, SearchService c a) => c -> IO [b]
    search model = toList <$> (R.search searchFunc model :: IO [a])
