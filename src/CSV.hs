{-# LANGUAGE NamedFieldPuns #-}
module CSV where


import           Data.List          (head)
import           Data.Maybe         (fromMaybe)
import           System.Environment
import           Text.CSV
import           Text.Read          (readMaybe)
import Types


parseFoodItem :: [String] -> FoodItem
parseFoodItem record = do
        case record of
            [ ta_ID, description, ingredients, price, category ] ->
                FoodItem
                    { ta_ID       = maybeInt ta_ID 
                    , description 
                    , ingredients 
                    , price       = maybeDouble price
                    , category    = maybeCategory category
                    }

            _ -> do
                FoodItem
                    { ta_ID       = 0
                    , description = ""
                    , ingredients = ""
                    , price       = 0.0
                    , category    = Pizza
                    }
        where
            maybeInt :: String -> Int 
            maybeInt =
                fromMaybe 0 . readMaybe

            maybeDouble :: String -> Double
            maybeDouble =
                fromMaybe 0.0 . readMaybe

            maybeCategory :: String -> Category
            maybeCategory =
                fromMaybe Pizza . toCategory 

toCategory :: String -> Maybe Category
toCategory string =
    case string of
        "Pizza"    -> Just Pizza
        "Salad"    -> Just Salad
        "Fastfood" -> Just Fastfood
        "Pasta"    -> Just Pasta
        "Drinks"   -> Just Drinks
        _          -> Nothing