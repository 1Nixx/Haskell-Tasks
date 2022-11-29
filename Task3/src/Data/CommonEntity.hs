module Data.CommonEntity 
    (Color(..))
where

data Color = Black 
            | White
            | Other
            deriving (Show, Read)
