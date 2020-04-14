{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Data.Text as Strict
import Data.Text.Lazy as Lazy

import Criterion.Main as Criterion

import Data.GenValidity
import Test.QuickCheck

import Data.GenValidity.Criterion
import Data.GenValidity.Text

main :: IO ()
main =
  Criterion.defaultMain
    [ bgroup
        "Instances"
        [ genBenchSizes "Strict.Text" (genValid @Strict.Text)
        , genBenchSizes "Lazy.Text" (genValid @Lazy.Text)
        ]
    , bgroup
        "Approaches"
        [ genBenchSizes "via list (old version)" $ Strict.pack <$> genValid
        , genBenchSizes "genText" genText
        , genBenchSizes "genTextBy genValid" $ genTextBy genValid
        , genBenchSizes "genTextBy (choose (minBound, maxBound)) (currently in use)" $
          genTextBy (choose (minBound, maxBound))
        ]
    ]
