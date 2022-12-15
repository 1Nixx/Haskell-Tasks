module Main (main) where

import qualified Controllers.Customer as CC
import qualified Controllers.Order as CO
import qualified Controllers.Product as CP
import qualified Controllers.Shop as CS

main :: IO ()
main = do
    putStrLn "\nCUSTOMERS\n"
    customers <- CC.getMany
    print customers

    putStrLn "\nCUSTOMER #2\n"
    customer <- CC.getOne 2
    print customer

    putStrLn "\nORDERS\n"
    orders <- CO.getMany
    print orders

    putStrLn "\nORDER #1\n"
    order <- CO.getOne 1
    print order

    putStrLn "\nPRODUCTS\n"
    products <- CP.getMany
    print products

    putStrLn "\nPRODUCT #2\n"
    product <- CP.getOne 2
    print product

    putStrLn "\nSHOPS\n"
    customers <- CS.getMany
    print customers

    putStrLn "\nSHOP #2\n"
    customer <- CS.getOne 2
    print customer

    putStrLn "\nORDER #10 ERROR\n"
    order <- CO.getOne 10
    print order

    putStrLn "\nCUSTOMER #4 PROCESS\n"
    custResult <- CC.process 4
    print custResult

    putStrLn "\nORDER #2 PROCESS\n"
    ordResult <- CO.process 2
    print ordResult

    putStrLn "\nPRODUCT #2 PROCESS\n"
    prodResult <- CP.process 2
    print prodResult

    putStrLn "\nSHOP #3 PROCESS\n"
    shopResult <- CS.process 3
    print shopResult
