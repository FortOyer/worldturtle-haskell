module Main where

import Control.Monad (forM_) -- Required control flow functions.

import Graphics.Gloss.Data.Color

import Graphics.WorldTurtle

colors :: [Color]
colors = cycle [rose, violet, azure, aquamarine, chartreuse, orange]

steps :: [(Float, Color)]
steps = zip [0..20] colors

main :: IO ()
main = runTurtle $ 
  forM_ steps $ \ (i, c) -> do
    setPenColor c
    forward (i * 10)
    right 144
