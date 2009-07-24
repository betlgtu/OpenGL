-- #hide
--------------------------------------------------------------------------------
-- |
-- Module      :  Graphics.Rendering.OpenGL.GL.BufferMode
-- Copyright   :  (c) Sven Panne 2002-2009
-- License     :  BSD-style (see the file libraries/OpenGL/LICENSE)
-- 
-- Maintainer  :  sven.panne@aedion.de
-- Stability   :  stable
-- Portability :  portable
--
-- This is a purely internal module for (un-)marshaling BufferMode.
--
--------------------------------------------------------------------------------

module Graphics.Rendering.OpenGL.GL.BufferMode (
   BufferMode(..), marshalBufferMode, unmarshalBufferMode
) where

import Graphics.Rendering.OpenGL.Raw.Core31
import Graphics.Rendering.OpenGL.Raw.ARB.Compatibility ( gl_AUX0 )

--------------------------------------------------------------------------------

-- | The set of color buffers which are selected for reading and writing.

data BufferMode =
     NoBuffers
     -- ^ No color buffers are selected.
   | FrontLeftBuffer
     -- ^ Only the front left color buffer is selected.
   | FrontRightBuffer
     -- ^ Only the front right color buffer is selected.
   | BackLeftBuffer
     -- ^ Only the  back left color buffer is selected.
   | BackRightBuffer
     -- ^ Only the back right color buffer is selected.
   | FrontBuffers
     -- ^ Only the front left and front right color buffers are selected. If
     -- there is no front right color buffer, only the front left color buffer
     -- is selected.
   | BackBuffers
     -- ^ Only the back left and back right color buffers are selected. If there
     -- is no back right color buffer, only the back left color buffer is
     -- selected.
   | LeftBuffers
     -- ^ Only the front left and back left color buffers are selected. If there
     -- is no back left color buffer, only the front left color buffer is
     -- selected.
   | RightBuffers
     -- ^ Only the front right and back right color buffers are selected. If
     -- there is no back right color buffer, only the front right color buffer
     -- is selected.
   | FrontAndBackBuffers
     -- ^ All the front and back color buffers (front left, front right, back
     -- left, back right) are selected. If there are no back color buffers, only
     -- the front left and front right color buffers are selected. If there are
     -- no right color buffers, only the front left and back left color buffers
     -- are selected. If there are no right or back color buffers, only the
     -- front left color buffer is selected.
   | AuxBuffer GLsizei
     -- ^ Only the given auxiliary color buffer no. /i/ is selected.
   deriving ( Eq, Ord, Show )

marshalBufferMode :: BufferMode -> Maybe GLenum
marshalBufferMode x = case x of
   NoBuffers -> Just gl_NONE
   FrontLeftBuffer -> Just gl_FRONT_LEFT
   FrontRightBuffer -> Just gl_FRONT_RIGHT
   BackLeftBuffer -> Just gl_BACK_LEFT
   BackRightBuffer -> Just gl_BACK_RIGHT
   FrontBuffers -> Just gl_FRONT
   BackBuffers -> Just gl_BACK
   LeftBuffers -> Just gl_LEFT
   RightBuffers -> Just gl_RIGHT
   FrontAndBackBuffers -> Just gl_FRONT_AND_BACK
   AuxBuffer i
      | fromIntegral i <= maxAuxBuffer -> Just (gl_AUX0 + fromIntegral i)
      | otherwise -> Nothing

unmarshalBufferMode :: GLenum -> BufferMode
unmarshalBufferMode x
   | x == gl_NONE = NoBuffers
   | x == gl_FRONT_LEFT = FrontLeftBuffer
   | x == gl_FRONT_RIGHT = FrontRightBuffer
   | x == gl_BACK_LEFT = BackLeftBuffer
   | x == gl_BACK_RIGHT = BackRightBuffer
   | x == gl_FRONT = FrontBuffers
   | x == gl_BACK = BackBuffers
   | x == gl_LEFT = LeftBuffers
   | x == gl_RIGHT = RightBuffers
   | x == gl_FRONT_AND_BACK = FrontAndBackBuffers
   | gl_AUX0 <= x && x <= gl_AUX0 + maxAuxBuffer = AuxBuffer (fromIntegral (x - gl_AUX0))
   | otherwise = error ("unmarshalBufferMode: illegal value " ++ show x)

maxAuxBuffer :: GLenum
maxAuxBuffer = 246
