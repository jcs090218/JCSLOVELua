-- ========================================================================
-- $File: jcslove_color.lua $
-- $Date: 2016-09-09 14:46:38 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


jcslove_color =
   {
      r = 255,
      g = 255,
      b = 255,
      a = 255,
   }


jcslove_color.__index = jcslove_color

------------------------------------------------
-- Constructor
------------------------------------------------
function jcslove_color.new(init)
   local newColor = {}
   setmetatable(newColor, jcslove_color)

   return newColor
end

------------------------------------------------
-- Set color to frame.
------------------------------------------------
function jcslove_color:draw()

   -- render by color setting.
   love.graphics.setColor(
      self.r,
      self.g,
      self.b,
      self.a)
end
