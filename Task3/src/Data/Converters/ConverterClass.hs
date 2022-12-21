module Data.Converters.ConverterClass (ReadWriteEntity(..)) where

class ReadWriteEntity a where
    readEntity :: [String] -> a
    insertEntityStr :: a -> String
    updateEntityStr :: a -> String
