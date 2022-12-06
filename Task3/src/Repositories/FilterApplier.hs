module Repositories.FilterApplier (applyFilter) where
import Data.Maybe (fromMaybe)

data SearchModel b = SearchModel {a :: b}

applyFilter :: (a -> b) -> (c -> Maybe b) -> (b -> b -> Bool) -> c -> [a] -> [a]
applyFilter arrSelect searchModelSelect funcfilter searchModel arr =
    let searchValue = searchModelSelect searchModel
    in case searchValue of
            Nothing -> arr
            Just value -> filter (funcfilter value . arrSelect) arr

applyFilter2 :: (a -> b) -> (c -> Maybe b) -> (b -> b -> Bool) -> c -> [a] -> [a]
applyFilter2 arrSelect searchModelSelect funcfilter searchModel arr =
    fromMaybe arr (searchModelSelect searchModel >>= \searchValue ->
    return $ filter (funcfilter searchValue . arrSelect) arr)