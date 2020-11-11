-- ========================================================================
-- $File: jcslove_sprite.lua $
-- $Date: 2016-09-12 04:14:54 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_math')


jcslove_sprite =
   {
      x = 0,  -- sprite position x
      y = 0,  -- sprite position y

      width = 0,  -- sprite width
      height = 0, -- sprite height

      pivotX = 0,
      pivotY = 0,

      degree = 0,
      flipX = false,
      flipY = false,

      scaleX = 1,
      scaleY = 1,

      gameObject = nil,

      sprite = nil, -- actual sprite in love 2d
   }



jcslove_sprite.__index = jcslove_sprite

------------------------------------------------
-- Constructor
------------------------------------------------
function jcslove_sprite.new(init, gameObject)
   local newSprite = {}
   setmetatable(newSprite, jcslove_sprite)

   newSprite.gameObject = gameObject

   return newSprite
end

------------------------------------------------
-- Render function
------------------------------------------------
function jcslove_sprite:draw()

   -- check if the sprite exist?
   if self.sprite == nil then
      return
   end


   local flipValX = self.scaleX
   local flipValY = self.scaleY

   local xVal = self.x
   local yVal = self.y

   if self.flipX == true then
      flipValX = -self.scaleX
      xVal = -math.abs(xVal)
   else
      xVal = math.abs(xVal)
   end

   if self.flipY == true then
      flipValY = -self.scaleY
      yVal = -math.abs(yVal)
   else
      yVal = math.abs(yVal)
   end

   -- NOTE(jenchieh): since love 2d provide
   -- radians, we have to  convert degree to radians.
   local radians = jcslove_math.DegreeToRadian(self.degree)

   love.graphics.draw(
      self.sprite,
      self.gameObject.x - xVal,
      self.gameObject.y - yVal,
      radians,
      flipValX,
      flipValY,
      self.pivotX,
      self.pivotY)
end


------------------------------------------------
-- Set the sprite and update the width
-- and height.
------------------------------------------------
-- @param spr: sprite u want to set.
------------------------------------------------
function jcslove_sprite:SetSprite(spr)
   self.sprite = spr

   self.width = self.sprite:getWidth()
   self.height = self.sprite:getHeight()
end

------------------------------------------------
-- Auto set the pivot to center
--
-- NOTE(jenchieh): only when the sprite are
-- right left or top down the same will be
-- good to use of this function call.
------------------------------------------------
function jcslove_sprite:AutoPivot()
   self.pivotX = self.width / 2
   self.pivotY = self.height / 2
end

------------------------------------------------
-- Set the scale to X
------------------------------------------------
-- @param val: set value
------------------------------------------------
function jcslove_sprite:SetScaleX(val)
   self.scaleX = math.abs(val)
end

------------------------------------------------
-- Set the scale to Y
------------------------------------------------
-- @param val: set value
------------------------------------------------
function jcslove_sprite:SetScaleY()
   self.scaleY = math.abs(val)
end
