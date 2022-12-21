{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE InstanceSigs #-}
{-# OPTIONS_GHC -Wno-orphans #-}

module Data.DatabaseRow (MSSQL.Row(..)) where

import qualified Database.MSSQLServer.Query as MSSQL
import Data.Entities (Order (..), Product (..), Customer (..), Shop (..), ProductOrder (..))
import Database.Tds.Message

instance MSSQL.Row Order where
    fromListOfRawBytes :: [MetaColumnData] -> [RawBytes] -> Order
    fromListOfRawBytes [m1, m2, m3] [b1, b2, b3] = Order d1 d2 d3
        where 
            !d1 = fromRawBytes (mcdTypeInfo m1) b1
            !d2 = fromRawBytes (mcdTypeInfo m2) b2
            !d3 = fromRawBytes (mcdTypeInfo m3) b3    

            mcdTypeInfo :: MetaColumnData -> TypeInfo
            mcdTypeInfo (MetaColumnData _ _ ti _ _) = ti

    fromListOfRawBytes _ _ = error "fromListOfRawBytes: List length must be 3"

instance MSSQL.Row Product where
    fromListOfRawBytes :: [MetaColumnData] -> [RawBytes] -> Product 
    fromListOfRawBytes [m1, m2, m3, m4, m5] [b1, b2, b3, b4, b5] = Product d1 d2 d3 d4 d5
        where 
            !d1 = fromRawBytes (mcdTypeInfo m1) b1
            !d2 = fromRawBytes (mcdTypeInfo m2) b2
            !d3 = fromRawBytes (mcdTypeInfo m3) b3   
            !d4 = fromRawBytes (mcdTypeInfo m4) b4
            !d5 = read $ fromRawBytes (mcdTypeInfo m5) b5  

            mcdTypeInfo :: MetaColumnData -> TypeInfo
            mcdTypeInfo (MetaColumnData _ _ ti _ _) = ti

    fromListOfRawBytes _ _ = error "fromListOfRawBytes: List length must be 5"

instance MSSQL.Row Customer where
    fromListOfRawBytes :: [MetaColumnData] -> [RawBytes] -> Customer
    fromListOfRawBytes [m1, m2, m3] [b1, b2, b3] = Customer d1 d2 d3
        where 
            !d1 = fromRawBytes (mcdTypeInfo m1) b1
            !d2 = fromRawBytes (mcdTypeInfo m2) b2
            !d3 = fromRawBytes (mcdTypeInfo m3) b3    

            mcdTypeInfo :: MetaColumnData -> TypeInfo
            mcdTypeInfo (MetaColumnData _ _ ti _ _) = ti

    fromListOfRawBytes _ _ = error "fromListOfRawBytes: List length must be 3"

instance MSSQL.Row Shop where
    fromListOfRawBytes :: [MetaColumnData] -> [RawBytes] -> Shop
    fromListOfRawBytes [m1, m2, m3] [b1, b2, b3] = Shop d1 d2 d3
        where 
            !d1 = fromRawBytes (mcdTypeInfo m1) b1
            !d2 = fromRawBytes (mcdTypeInfo m2) b2
            !d3 = fromRawBytes (mcdTypeInfo m3) b3    

            mcdTypeInfo :: MetaColumnData -> TypeInfo
            mcdTypeInfo (MetaColumnData _ _ ti _ _) = ti

    fromListOfRawBytes _ _ = error "fromListOfRawBytes: List length must be 3"

instance MSSQL.Row ProductOrder where
    fromListOfRawBytes :: [MetaColumnData] -> [RawBytes] -> ProductOrder
    fromListOfRawBytes [m1, m2, m3] [b1, b2, b3] = ProductOrder d1 d2 d3
        where 
            !d1 = fromRawBytes (mcdTypeInfo m1) b1
            !d2 = fromRawBytes (mcdTypeInfo m2) b2
            !d3 = fromRawBytes (mcdTypeInfo m3) b3    

            mcdTypeInfo :: MetaColumnData -> TypeInfo
            mcdTypeInfo (MetaColumnData _ _ ti _ _) = ti

    fromListOfRawBytes _ _ = error "fromListOfRawBytes: List length must be 3"