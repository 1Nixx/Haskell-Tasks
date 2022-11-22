{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Utils.Utils (maybeHead) where

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x