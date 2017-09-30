-------------------------------------------------------------------------------
-- |
-- Module    :  Reinforce.Prelude
-- Copyright :  (c) Sentenai 2017
-- License   :  BSD3
-- Maintainer:  sam@sentenai.com
-- Stability :  experimental
-- Portability: non-portable
--
-- Re-exports of common functions and newer functions
-------------------------------------------------------------------------------
{-# LANGUAGE ConstraintKinds #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE CPP #-}
module Reinforce.Prelude
  ( module X
  , whileM_
  , head
  , unsafeHead
  , printIO
  , impossible
  ) where

import Prelude as X hiding (head)

import Control.Applicative      as X
import Control.Exception.Safe   as X
import Control.Monad.Identity   as X
import Control.Monad.Reader     as X
import Control.Monad.RWS.Strict as X hiding ((<>))
import Control.Monad.Writer.Strict as X (Writer, WriterT)
import Control.Monad.State      as X
import Control.Monad            as X (void)

import Data.DList     as X (DList(..))
import Data.Hashable  as X
import Data.List      as X (intercalate, maximumBy)
import Data.Monoid    as X
import Data.Ord       as X
import Data.Proxy     as X (Proxy(..))
import Data.Text      as X (Text)
import Data.Vector    as X (Vector)

import GHC.Float     as X
import GHC.Generics  as X (Generic)
import GHC.TypeLits  as X

import Lens.Micro.Platform             as X
import Statistics.Distribution.Normal  as X (normalDistr, NormalDistribution)
import System.Random.MWC               as X (GenIO, Variate)

-- ========================================================================= --

import qualified Prelude as P (head)

-- | A monadic while loop
whileM_ :: forall m a . Monad m => m Bool -> m a -> m ()
whileM_ p f = go
  where
    go :: m ()
    go = p >>= decide

    decide :: Bool -> m ()
    decide True  = return ()
    decide False = f >> go

-- | a safer @head@ with something safer
head :: [a] -> Maybe a
head [] = Nothing
head as = Just $ P.head as

-- | Prelude's @head@ - for capatability.
unsafeHead :: [a] -> a
unsafeHead = P.head

printIO :: (Show a, MonadIO m) => a -> m ()
printIO = liftIO . print

impossible :: String -> x
impossible = error
