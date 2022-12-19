{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Utils.Cache (CacheAccess(..)) where

import Data.Entities (Customer, Order, Shop, Product, ProductOrder)
import qualified Control.Monad.State as S
import Data.AppTypes (AppCache (..), App, AppState (cache))


class CacheAccess a where
    getCache :: AppCache -> [a]

    setCache :: AppCache -> [a] -> AppCache

    clearCache :: App ()
    clearCache = 
        S.get >>= \oldState ->
        let newCache = setCache (cache oldState) ([] :: [a])
        in S.put oldState {cache = newCache}

instance CacheAccess Customer where
    getCache :: AppCache -> [Customer]
    getCache = customerCache
    setCache :: AppCache -> [Customer] -> AppCache
    setCache state xs = state { customerCache = xs }
    
instance CacheAccess Order where  
    getCache :: AppCache -> [Order]
    getCache = orderCache
    setCache :: AppCache -> [Order] -> AppCache
    setCache state xs = state { orderCache = xs }

instance CacheAccess Shop where
    getCache :: AppCache -> [Shop]
    getCache = shopCache
    setCache :: AppCache -> [Shop] -> AppCache
    setCache state xs = state { shopCache = xs }

instance CacheAccess Product where
    getCache :: AppCache -> [Product]
    getCache = productCache
    setCache :: AppCache -> [Product] -> AppCache
    setCache state xs = state { productCache = xs }
    
instance CacheAccess ProductOrder where
    getCache :: AppCache -> [ProductOrder]
    getCache = productOrderCache
    setCache :: AppCache -> [ProductOrder] -> AppCache
    setCache state xs = state { productOrderCache = xs }

