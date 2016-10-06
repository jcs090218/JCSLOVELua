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
love.mouse.mousePressed = { }
love.mouse.mouseReleased = { }

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
-- Get the mouse button
------------------------------------------------
function jcslove_input.GetMouseButton(key)
   return love.mouse.isDown(key)
end

------------------------------------------------
-- Get mouse button down/pressed
------------------------------------------------
function jcslove_input.GetMouseButtonDown(key)
   if (love.mouse.mousePressed[key]) then
      return true
   end

   return false
end

------------------------------------------------
-- Get mouse button up/released
------------------------------------------------
function jcslove_input.GetMouseButtonUp(key)
   if (love.mouse.mouseReleased[key]) then
      return true
   end

   return false
end

------------------------------------------------
-- concatenate this to existing love.
-- keypressed callback, if any
------------------------------------------------
-- @param key: key pressed
------------------------------------------------
function love.keypressed(key)
   love.keyboard.keysPressed[key] = true
end

------------------------------------------------
-- concatenate this to existing love.
-- keyreleased callback, if any
------------------------------------------------
-- @param key: key release
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


------------------------------------------------
--
------------------------------------------------
-- @param key: mouse pressed
------------------------------------------------
function love.mousepressed(x, y, button, istouch)
   love.mouse.mousePressed[button] = true
end

------------------------------------------------
--
------------------------------------------------
-- @param key: mouse release
------------------------------------------------
function love.mousereleased(x, y, button)
   love.mouse.mouseReleased[button] = true
end

------------------------------------------------
-- Reset mouse buffer from previous frame.
------------------------------------------------
function jcslove_input.ResetMouseButton()
   -- reset table.
   love.mouse.mousePressed = { }
   love.mouse.mouseReleased = { }
end

------------------------------------------------
-- Reset whole input buffer from previous frame.
------------------------------------------------
function jcslove_input.ResetInputBuffer()
   jcslove_input.ResetKeys()
   jcslove_input.ResetMouseButton()
end
