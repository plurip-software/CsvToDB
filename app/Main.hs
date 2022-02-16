{-# LANGUAGE NamedFieldPuns #-}

module Main where

import           Data.List          (head)
import           Data.List.Split    (splitOn)
import           Data.Maybe         (fromMaybe)
import           System.Environment
import           Text.CSV
import           Text.Read          (readMaybe)
import           CSV (parseFoodItem)
import           MySQL(connect, insertFoods, foodsStatement)
import Types

main :: IO ()
main = do

    -- Get command line arguments
    args <- getArgs

    -- Get food items from CSV file
    --
    eitherCsv <- parseCSVFromFile $ head args -- "Some CSV file path"
    
    let foodItems = case eitherCsv of
            Left err -> []
            Right response -> map parseFoodItem response

    -- Insert food items into MySQL DB
    -- 
    conn <- 
        connect
            (Host "s89.goserver.host") 
            (User "web243_2")
            (Password "SchoeneNeueWelt")
            (DB "web243_db2")

    -- Prepare SQL-Statement
    --
    stmt <- foodsStatement conn

    -- Insert rows into MySQL SB
    --
    insertFoods stmt foodItems