module Data.Converters.ConverterClass (ReadWriteEntity(..)) where

class ReadWriteEntity a where
    readEntity :: [String] -> a
    writeEntity :: a -> String
