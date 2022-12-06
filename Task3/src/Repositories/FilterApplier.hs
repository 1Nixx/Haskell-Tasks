{-# OPTIONS_GHC -Wno-redundant-constraints #-}

module Repositories.FilterApplier 
    ( applyFilter
    , applyPagination) where
import Data.Maybe (fromMaybe)
import Data.SearchModels (SearchModel(..))

applyFilter ::(SearchModel c) => (a -> b) -> (c -> Maybe b) -> (b -> b -> Bool) -> c -> [a] -> [a]
applyFilter arrSelect searchModelSelect funcfilter searchModel arr =
    fromMaybe arr (searchModelSelect searchModel >>= \searchValue ->
    return $ filter (funcfilter searchValue . arrSelect) arr)

applyPagination :: Int -> Int -> [a] -> [a]
applyPagination page pageSize = 
    take pageSize . drop ((page - 1) * pageSize)