{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Utils.Cache (CacheAccess(..)) where

import Data.App (AppState (..), App)
import Data.Entities (Customer, Order, Shop, Product, ProductOrder)
import qualified Control.Monad.State as S

class CacheAccess a where
    getCache :: AppState -> [a]

    setCache :: AppState -> [a] -> AppState

    clearCache :: App ()
    clearCache = 
        S.get >>= \oldState ->
        let newCache = setCache oldState ([] :: [a])
        in S.put newCache

instance CacheAccess Customer where
    getCache :: AppState -> [Customer]
    getCache = customerCache
    setCache :: AppState -> [Customer] -> AppState
    setCache state xs = state { customerCache = xs }
    
instance CacheAccess Order where  
    getCache :: AppState -> [Order]
    getCache = orderCache
    setCache :: AppState -> [Order] -> AppState
    setCache state xs = state { orderCache = xs }

instance CacheAccess Shop where
    getCache :: AppState -> [Shop]
    getCache = shopCache
    setCache :: AppState -> [Shop] -> AppState
    setCache state xs = state { shopCache = xs }

instance CacheAccess Product where
    getCache :: AppState -> [Product]
    getCache = productCache
    setCache :: AppState -> [Product] -> AppState
    setCache state xs = state { productCache = xs }
    
instance CacheAccess ProductOrder where
    getCache :: AppState -> [ProductOrder]
    getCache = productOrderCache
    setCache :: AppState -> [ProductOrder] -> AppState
    setCache state xs = state { productOrderCache = xs }

