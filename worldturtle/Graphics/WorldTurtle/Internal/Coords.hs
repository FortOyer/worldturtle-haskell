{-# OPTIONS_HADDOCK hide #-}
{-# LANGUAGE BangPatterns #-}
module Graphics.WorldTurtle.Internal.Coords
  ( module GPoint
  , module GArithmetic
  , module GVector
  , module GAngle
  , lerp
  , normalizeHeading
  ) where

import Prelude hiding ((-), (+))
import qualified Prelude as P

import Graphics.Gloss.Data.Point as GPoint
import Graphics.Gloss.Data.Point.Arithmetic as GArithmetic
import Graphics.Gloss.Data.Vector as GVector
import Graphics.Gloss.Geometry.Angle as GAngle

-- | What it says on the tin. A lerp function. 
lerp :: Float -- Coefficient between 0 and 1.
     -> Point -- Point /a/.
     -> Point -- Point /b/.
     -> Point -- new point some percentage value between /a/ and /b/.
lerp !l !a !b = let (!ux, !uy) = (1 P.- l) `mulSV` a
                    (!vx, !vy) = l `mulSV` b
                    !n = (ux P.+ vx, uy P.+ vy)
               in n

-- | Return a valid heading value between (0, 360].
--   We want 360 to be 360 (full rotation).
--   We want 361 to be 1 (wraparound rotation).
--   Special case: we want 0 to be 0 (no rotation). Though really 0 is equal to
--   360 we will let this special case slide as it helps in our time elapsed 
--   calculations.
normalizeHeading :: Float -> Float
normalizeHeading 0 = 0
normalizeHeading f = let (n, b) = properFraction f :: (Int, Float)
                         f' = fromIntegral (n `rem` 360) P.+ b
                      in if f' <= 0 then f' P.+ 360 else f'
