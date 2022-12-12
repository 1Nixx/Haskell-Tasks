module Data.ServiceEntity (ServiceEntity) where
import Data.Models (CustomerModel, OrderModel, ProductModel, ShopModel)

class ServiceEntity a where

instance ServiceEntity CustomerModel
instance ServiceEntity OrderModel
instance ServiceEntity ProductModel
instance ServiceEntity ShopModel