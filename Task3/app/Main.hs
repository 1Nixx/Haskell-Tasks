module Main (main) where

import qualified Controllers.Customer as CC
import qualified Controllers.Order as CO
import qualified Controllers.Product as CP
import qualified Controllers.Shop as CS
import Data.AppTypes (AppResult(result))

main :: IO ()
main = do
    putStrLn "\nCUSTOMERS\n"
    customers <- CC.getMany  
    print $ result customers

    -- putStrLn "\nCUSTOMER #2\n"
    -- customer <- CC.getOne 2
    -- print $ result customer

    -- putStrLn "\nORDERS\n"
    -- orders <- CO.getMany
    -- print $ result orders

    -- putStrLn "\nORDER #1\n"
    -- order <- CO.getOne 1
    -- print $ result order

    -- putStrLn "\nPRODUCTS\n"
    -- products <- CP.getMany
    -- print $ result products

    -- putStrLn "\nPRODUCT #2\n"
    -- product <- CP.getOne 2
    -- print $ result product

    -- putStrLn "\nSHOPS\n"
    -- customers <- CS.getMany
    -- print $ result customers

    -- putStrLn "\nSHOP #2\n"
    -- customer <- CS.getOne 2
    -- print $ result customer

    -- putStrLn "\nORDER #10 ERROR\n"
    -- order <- CO.getOne 10
    -- print $ result order

    -- putStrLn "\nCUSTOMER #4 PROCESS\n"
    -- custResult <- CC.process 4
    -- print $ result custResult

    -- putStrLn "\nORDER #2 PROCESS\n"
    -- ordResult <- CO.process 2
    -- print $ result ordResult

    -- putStrLn "\nPRODUCT #2 PROCESS\n"
    -- prodResult <- CP.process 2
    -- print $ result prodResult

    -- putStrLn "\nSHOP #3 PROCESS\n"
    -- shopResult <- CS.process 3
    -- print $ result shopResult
