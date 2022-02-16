{-# LANGUAGE CPP, OverloadedStrings #-}
{-# LANGUAGE NamedFieldPuns #-}
{-# LANGUAGE RankNTypes #-}

module MySQL where

import Control.Monad
import Database.HDBC
import Database.HDBC.ODBC
import Types

-- This is how to connect to our test database
connect :: Host -> User -> Password -> DB -> IO Connection
connect (Host host) (User user) (Password password) (DB db) = 
    -- R
    connectODBC $ "Driver={MySQL ODBC 8.0 UNICODE Driver};Server=" ++ host ++ ";Database=" ++ db ++ ";User=" ++ user ++ ";Password=" ++ password ++ ";Option=262144;SSLMODE=DISABLED;"
    
toFoodValues :: FoodItem -> FoodValues
toFoodValues FoodItem {ta_ID, description, ingredients, price, category} =
    [ toSql (ta_ID :: ID)
    , toSql description
    , toSql ingredients
    , toSql (price :: Price)
    , toSql $ show category
    ]

foodsStatement :: Connection -> IO Statement
foodsStatement conn = 
    prepare conn "INSERT INTO foods (ta_ID, description, ingredients, price, category) VALUES (?,?,?,?,?)"

insertFoods :: Statement -> [FoodItem] -> IO ()
insertFoods stmt foodItems =
    executeMany stmt (map toFoodValues foodItems)