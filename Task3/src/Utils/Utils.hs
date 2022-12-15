module Utils.Utils (maybeHead, unwrap, validateArr, validateMaybe) where
import Data.Maybe (fromMaybe)
import Data.App
import Control.Monad.Except

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x

unwrap :: App (Maybe (App (Maybe a))) -> App (Maybe a)
unwrap m = m >>= fromMaybe (return Nothing)

validateArr :: [a] -> App a
validateArr [] = throwError ElementNotFound
validateArr (x:_) = return x

validateMaybe :: Maybe a -> App a
validateMaybe Nothing = throwError ElementNotFound
validateMaybe (Just a) = return a 