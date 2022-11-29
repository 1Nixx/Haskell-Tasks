module Data.Converters.Converter (ReadEntity(..)) where

class ReadEntity a where
    readEntity :: [String] -> a

