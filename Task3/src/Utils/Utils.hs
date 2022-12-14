module Utils.Utils (maybeHead, unwrap) where
import Data.Maybe (fromMaybe)
import Data.App (App)

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x

unwrap :: App (Maybe (App (Maybe a))) -> App (Maybe a)
unwrap m = m >>= fromMaybe (return Nothing)