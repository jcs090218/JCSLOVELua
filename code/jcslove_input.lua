-- ========================================================================
-- $File: jcslove_input.lua $
-- $Date: 2016-09-19 03:55:05 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-----------------------------------------------------------
-- Handle input --
-- SOURCE: http://yal.cc/love2d-functions-to-check-if-key-was-pressedreleased/
-- IMPORTANT: If u going to use this class as the utility. Plz
-- do not implemented these following function in ur code.
--
--      1) love.keypressed(key)
--      2) love.keyreleased(key)
--
-- Enjoy!~
-----------------------------------------------------------


jcslove_input = {}

-- declare the tables
love.keyboard.keysPressed = { }
love.keyboard.keysReleased = { }

------------------------------------------------
--
------------------------------------------------
-- @param key: string of the key
------------------------------------------------
function jcslove_input.GetKey(key)
   return love.keyboard.isDown(key)
end

------------------------------------------------
--
------------------------------------------------
-- @param key: string of the key
------------------------------------------------
function jcslove_input.GetKeyDown(key)
   if (love.keyboard.keysPressed[key]) then
      return true
   end

   return false
end

------------------------------------------------
-- Returns if specified key was released since
-- last update
------------------------------------------------
-- @param key: string of the key
------------------------------------------------
function jcslove_input.GetKeyUp(key)
   if (love.keyboard.keysReleased[key]) then
      return true
   end

   return false
end


------------------------------------------------
-- concatenate this to existing love.
-- keypressed callback, if any
------------------------------------------------
--
------------------------------------------------
function love.keypressed(key)
   love.keyboard.keysPressed[key] = true
end

------------------------------------------------
-- concatenate this to existing love.
-- keyreleased callback, if any
------------------------------------------------
--
------------------------------------------------
function love.keyreleased(key)
   love.keyboard.keysReleased[key] = true
end

------------------------------------------------
-- call in end of each love.update to reset lists
-- of pressed\released keys
------------------------------------------------
function jcslove_input.ResetKeys()
   -- reset table.
   love.keyboard.keysPressed = { }
   love.keyboard.keysReleased = { }
end
