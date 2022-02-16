{-# LANGUAGE DataKinds #-}
module Types where

import Database.HDBC

data FoodItem
    = FoodItem
        { ta_ID       :: ID
        , description :: Description
        , ingredients :: Ingredients
        , price       :: Price
        , category    :: Category
        } deriving Show

type ID = Int

type Index = Int

type Description = String

type Ingredients = String

type Price = Double 

data Category
    = Pizza
    | Salad
    | Fastfood
    | Pasta
    | Drinks
    deriving Show

newtype Host = Host String

newtype User = User String

newtype Password = Password String

newtype DB = DB String

type FoodValues = 
    [ SqlValue ]