{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Services.GenericService.GenericServiceClass (GenericService(..)) where

import Mappings.Mappings (Mapping(..))
import Data.RepositoryEntity.RepositoryEntity (RepositoryEntity(..))
import Repositories.GenericRepository.GenericRepository as R
import Data.SearchModels (SearchModel)
import Services.SearchService (SearchService(searchFunc))

class (RepositoryEntity a, Mapping a b, Mapping b a) => GenericService a b where
    getList :: IO [b]
    getList = map (\as -> toModel as :: b) <$> (R.getList :: IO a)

    add :: a -> IO Int
    add model = 
        let model' = toModel model :: a
        in R.add model'

    edit :: a -> IO ()
    edit model = 
        let model' = toModel model :: a
        in R.edit model'

    delete :: Int -> IO ()
    delete = R.delete @a

    search :: (SearchModel c) => c -> IO [b]
    search model = map toModel <$> R.search searchFunc model
