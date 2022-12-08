module Utils.Utils (maybeHead, unwrap) where
import Data.Maybe (fromMaybe)

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x

unwrap :: IO (Maybe (IO (Maybe a))) -> IO (Maybe a)
unwrap m = m >>= fromMaybe (return Nothing)