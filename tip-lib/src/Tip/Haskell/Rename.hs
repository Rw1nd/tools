{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}
module Tip.Haskell.Rename (renameDecls, isOperator, RenameMap) where

#include "errors.h"
import Tip.Haskell.Repr
import Tip.Haskell.Translate
import Tip.Utils.Rename
import Tip.Pretty

import Data.Set (Set)
import qualified Data.Set as S

import Data.Map (Map)
import qualified Data.Map as M

import Data.Char

import qualified Data.Foldable as F

type RenameMap a = Map (HsId a) (HsId String)

renameDecls :: forall a . (Ord a,PrettyVar a) => Decls (HsId a) -> (Decls (HsId String),RenameMap a)
renameDecls ds = runRenameM suggest blocks M.empty (rename ds)
  where
  blocks = map Other (keywords ++ map snd hsBuiltins ++ exacts)

  exacts :: [String]
  exacts = [ s | Exact s <- F.toList ds ]
        ++ [ s | Qualified _ _ s <- F.toList ds ]

  suggest :: HsId a -> [HsId String]
  suggest (Qualified m ms s) = Qualified m ms s:__
  suggest (Exact s) = Exact s:__
  suggest i
    | i `S.member` us = map (Other . upper) (disambigHs (makeUniform (varStr i)))
    | otherwise       = map (Other . lower) (disambigHs (makeUniform (varStr i)))

  us = uppercase ds

uppercase :: Ord a => Decls a -> Set a
uppercase (Decls ds) = S.fromList $
    [ x | TypeDef (TyCon x _) _ <- ds ] ++
    [ x | DataDecl x _ _ _ <- ds ] ++
    [ x | DataDecl _ _ cons _ <- ds, (x,_) <- cons ]

makeUniform :: String -> String
makeUniform s
    | couldBeOperator s = filter (`elem` opSyms) s
    | otherwise    = initialAlpha (filter isAlphaNum s)

initialAlpha :: String -> String
initialAlpha s@(c:_) | isAlpha c = s
                     | otherwise = 'x':s
initialAlpha [] = __

disambigHs :: String -> [String]
disambigHs s
    | isOperator s = s : [ s ++ replicate n '.' | n <- [1..] ]
    | otherwise    = disambig id s

upper :: String -> String
upper s@(c:r)
    | isOperator s = if c == ':' then s else ':':s
    | otherwise    = if isUpper c then s else toUpper c:r
upper [] = __

lower :: String -> String
lower s@(c:r)
    | isOperator s = if c == ':' then r else s
    | otherwise    = if isLower c then s else toLower c:r
lower [] = __

isOperator :: String -> Bool
isOperator = all (`elem` opSyms)

couldBeOperator :: String -> Bool
couldBeOperator s = i2d (numOps s) / i2d (length s) >= 0.5
  where
  i2d :: Int -> Double
  i2d = fromInteger . toInteger

numOps :: String -> Int
numOps = length . filter (`elem` opSyms)

opSyms :: String
opSyms = "!#$%&*+./<=>?@\\^|-~:"

keywords :: [String]
keywords =
  [ "!"
  , "'"
  , "''"
  , "-"
  , "--"
  , "-<"
  , "-<<"
  , "->"
  , "::"
  , ";"
  , "<-"
  , ","
  , "="
  , "=>"
  , ">"
  , "?"
  , "#"
  , "*"
  , "@"
  , "\\"
  , "_"
  , "`"
  , "|"
  , "~"
  , "as"
  , "case", "of"
  , "class"
  , "data"
  , "family"
  , "instance"
  , "default"
  , "deriving"
  , "do"
  , "forall"
  , "foreign"
  , "hiding"
  , "if", "then", "else"
  , "import"
  , "infix", "infixl", "infixr"
  , "let", "in"
  , "mdo"
  , "module"
  , "newtype"
  , "proc"
  , "qualified"
  , "rec"
  , "type"
  , "family"
  , "where"
  ]
