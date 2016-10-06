-- ========================================================================
-- $File: jcslove_shape.lua $
-- $Date: 2016-09-12 08:36:05 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- Handle Shape and Collision --

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_gameobject')
require (_PACKAGE .. '/jcslove_collision')


jcslove_shape =
   {
      gameObject = nil,

      x = 0,
      y = 0,

      localX = 0,
      localY = 0,

      width = 30,        -- default: 30
      height = 30,       -- default: 30
      radius = 30,       -- default: 30

      shapeType = "rect",   -- type of the shape (rect/circ)
   }

jcslove_shape.__index = jcslove_shape

------------------------------------------------
-- Constructor
------------------------------------------------
-- @param gameObject: game object we are on.
------------------------------------------------
function jcslove_shape.new(init, gameObject)
   local newShape = {}
   setmetatable(newShape, jcslove_shape)

   newShape.gameObject = gameObject

   return newShape
end


------------------------------------------------
-- Update logic.
------------------------------------------------
function jcslove_shape:update(dt)
   -- update position.
   self.x = self.gameObject.x - self.localX
   self.y = self.gameObject.y - self.localY
end

------------------------------------------------
-- Update graphics
------------------------------------------------
function jcslove_shape:draw()

   -- Don't render the collision if
   -- not in the debug mode.
   if jcslove_debug.DEBUG == false then
      return
   end

   -- update color.
   jcslove_debug.DebugColor()

   -- draw collider base on the shape.
   if self.shapeType == "rect" then

      love.graphics.rectangle(
         "fill",
         self.x,
         self.y,
         self.width,
         self.height)

   elseif self.shapeType == "circ" then

      love.graphics.circle(
         "fill",
         self.x,
         self.y,
         self.radius)
   else
      jcslove_debug.Informational("Collision shap does not exists in the list.")
   end

end
