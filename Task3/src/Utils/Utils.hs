{-# LANGUAGE RankNTypes #-}
module Utils.Utils (maybeHead, unwrap, validateArr, validateMaybe) where
import Data.Maybe (fromMaybe)
import Control.Monad.Except
import Data.AppTypes (App, AppError (ElementNotFound))

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x

unwrap :: App (Maybe (App (Maybe a))) -> App (Maybe a)
unwrap m = m >>= fromMaybe (return Nothing)

validateArr :: Int -> String -> [a] ->  App a
validateArr eid eName [] = throwError (ElementNotFound (eName ++ " : can't find id - " ++ show eid))
validateArr _ _ (x:_)  = return x

validateMaybe :: Int -> String -> Maybe a -> App a
validateMaybe eid eName Nothing = throwError (ElementNotFound (eName ++ " : can't find id - " ++ show eid))
validateMaybe _ _ (Just a) = return a 