-- Very bad dead code elimination (doesn't detect dead recursive functions).

{-# LANGUAGE RecordWildCards #-}
module Tip.Pass.EliminateDeadCode where

import Tip.Core
import qualified Data.Set as Set
import Data.Generics.Geniplate

eliminateDeadCode :: Ord a => Theory a -> Theory a
eliminateDeadCode = fixpoint elim
  where
    elim thy@Theory{..} =
      thy {
        thy_sigs = filter sigAlive thy_sigs,
        thy_funcs = filter funcAlive thy_funcs }
      where
        live = Set.fromList (map gbl_name (universeBi thy))
        sigAlive s = Set.member (sig_name s) live || hasAttr keep s
        funcAlive f = Set.member (func_name f) live || hasAttr keep f

fixpoint :: Eq a => (a -> a) -> a -> a
fixpoint f x
  | x == y = x
  | otherwise = fixpoint f y
  where
    y = f x
