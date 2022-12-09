{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeApplications #-}

module Services.GenericService.GenericServiceClass (GenericService(..)) where

import Repositories.GenericRepository.GenericRepository as R
import Mappings.Mappings (Mapping(..))
import Data.RepositoryEntity.RepositoryEntity (RepositoryEntity(..))
import Data.SearchModels (SearchModel)
import Services.SearchService (SearchService(..))
import Data.ServiceEntity.ServiceEntity (ServiceEntity(..))

class (RepositoryEntity a, ServiceEntity b) => GenericService a b where
    getList :: (Mapping b a) => IO [b]
    getList = map (\as -> toModel as) <$> (R.getList :: IO a)

    add :: b -> IO Int
    add model = 
        let model' = toModel model :: a
        in R.add model'

    edit :: b -> IO ()
    edit model = 
        let model' = toModel model :: a
        in R.edit model'

    delete :: Int -> IO ()
    delete = R.delete @a

    search :: (SearchModel c) => c -> IO [b]
    search model = map toModel <$> R.search searchFunc model
