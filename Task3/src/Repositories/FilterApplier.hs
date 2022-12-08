{-# OPTIONS_GHC -Wno-redundant-constraints #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Repositories.FilterApplier
    ( applyFilter
    , applyPagination) where
import Data.SearchModels (SearchModel(..))

applyFilter :: forall a b c. (SearchModel c) => (a -> b) -> (c -> Maybe b) -> (b -> b -> Bool) -> c -> [a] -> [a]
applyFilter arrSelect searchModelSelect funcfilter searchModel arr =
    let maybeSearchValue = searchModelSelect searchModel
    in searchInArr maybeSearchValue  
    where
        searchInArr :: Maybe b  -> [a]
        searchInArr (Just value)  = filter (funcfilter value . arrSelect) arr
        searchInArr Nothing = arr

applyPagination :: Int -> Int -> [a] -> [a]
applyPagination page pageSize =
    take pageSize . drop ((page - 1) * pageSize)