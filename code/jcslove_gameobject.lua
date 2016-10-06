-- ========================================================================
-- $File: jcslove_gameobject.lua $
-- $Date: 2016-09-09 11:18:04 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- DESCRIPTION:

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_color')
require (_PACKAGE .. '/jcslove_sprite')
require (_PACKAGE .. '/jcslove_animation')
require (_PACKAGE .. '/jcslove_animator')


jcslove_gameobject =
   {
      name = nil,

      shape = nil,

      x = 0,    -- x position
      y = 0,    -- y position
      pivotX = 0,
      pivoxY = 0,

      -- TODO(jenchieh): work on composition?
      velocity = nil,

      sprite = nil,     -- sprite buffer
      animation = nil,  -- single aniamtion
      animator = nil,   -- multiple animations

      active = true,    -- active or not active
      color = nil
   }

jcslove_gameobject.__index = jcslove_gameobject


------------------------------------------------
-- Constructor
------------------------------------------------
function jcslove_gameobject.new(init)
   local newGameObject = {}
   setmetatable(newGameObject, jcslove_gameobject)

   -- instances
   newGameObject.sprite = jcslove_sprite:new(newGameObject)
   newGameObject.animation = jcslove_animation:new(newGameObject)
   newGameObject.color = jcslove_color:new()
   newGameObject.shape = jcslove_shape:new(newGameObject)
   newGameObject.velocity =
      {
         x = 0,
         y = 0,
      }
   newGameObject.animator = jcslove_animator:new(newGameObject)

   -- set name to the default.
   newGameObject.name = "GameObject"

   return newGameObject
end


------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_gameobject:update(dt)

   -- NOTE(JenChieh): if the object itself is
   -- not active, pop the stack frame
   if self.active == false then
      return
   end

   -- do any logic here...

   -- apply force
   self.x = self.x + (dt * self.velocity.x)
   self.y = self.y + (dt * self.velocity.y)

   -- update animation
   self.animation:update(dt)

   -- update animator
   self.animator:update(dt)

   -- update position and offset.
   self.shape:update(dt)
end

------------------------------------------------
-- Update graphics
------------------------------------------------
function jcslove_gameobject:draw()

   -- NOTE(JenChieh): if the object itself is
   -- not active, pop the stack frame
   if self.active == false then
      return
   end

   -- set the current color frame
   self.color:draw()

   if self.animator.length ~= 0 then
      -- NOTE(jenchieh): "animator" have the
      -- higher priority to be render.

      -- draw the animator.
      self.animator:draw()

   elseif self.animation.frameCount ~= 0 then
      -- NOTE(jenchieh): "animation" have the
      -- higher priority to be render.

      -- draw the animation
      self.animation:draw()
   elseif self.sprite ~= nil then
      -- draw the sprite.
      self.sprite:draw()
   end

   -- draw the collision shape
   self.shape:draw()

end


------------------------------------------------
-- Set the collider base on the sprite
-- width/height/radius.
--
-- NOTE: Better dont do it every frame?
------------------------------------------------
-- @param tp: enum shape
--          * Rectangle
--          * Circle
------------------------------------------------
function jcslove_gameobject:AutoCollision(tp)

   -- do nothing if the sprite is nil
   if self.sprite == nil then
      return
   end

   -- switch
   if tp == "rect" then
      self.width = self.sprite.sprite:getWidth()
      self.heigt = self.sprite.sprite:getHeight()
   elseif tp == "circ" then
      local width = self.sprite.sprite:getWidth()
      local height = self.sprite.sprite:getHeight()

      local hyp = jcslove_math.PythTheo(width, height, "hyp")
      self.radius = (hyp / 2)
   else
      jcslove_debug.Error("Shap u enter isnt the shape listed here.")
   end

end

------------------------------------------------
--
------------------------------------------------
-- @param tp: rec, circ
------------------------------------------------
function jcslove_gameobject:AutoOffsetSprite(tp)

   if self.sprite == nil then
      return
   end


   if tp == "rect" then

   elseif tp == "circ" then
      local width = self.sprite.sprite:getWidth()
      local height = self.sprite.sprite:getHeight()

      self.sprite.x = width / 2
      self.sprite.y = height / 2
   else
      jcslove_debug.Error("Shap u enter isnt the shape listed here.")
   end
end

------------------------------------------------
--
------------------------------------------------
-- @param tp: rec, circ
------------------------------------------------
function jcslove_gameobject:AutoOffsetAnim(tp)

end

------------------------------------------------
-- Auto offset base on the texture priority.
------------------------------------------------
-- @param tp: rec, circ
------------------------------------------------
function jcslove_gameobject:AutoOffsetTexture(tp)

   -- Offset base on the texture type.
   if self.animation.frameCount ~= 0 then
      jcslove_gameobject:AutoOffsetAnim(tp)
   end

   if self.sprite ~= nil then
      jcslove_gameobject:AutoOffsetSprite(tp)
   end

end

------------------------------------------------
-- Return sprite from love 2d engine.
------------------------------------------------
-- @return sprite: the sprite api/object loaded by
-- love2d engine.
--
-- NOTE: only use it when u want
-- to access the engine layer.
------------------------------------------------
function jcslove_gameobject:GetSpriteSprite()
   return self.sprite.sprite
end

------------------------------------------------
-- Set the sprite into love2d engine's sprite
-- system.
--
-- NOTE: only use it when u want
-- to access the engine layer.
------------------------------------------------
-- @param spr: sprite u want to set
------------------------------------------------
function jcslove_gameobject:SetSpriteSprite(spr)
   self.sprite:SetSprite(spr)
end

------------------------------------------------
-- Set the type of the shape
------------------------------------------------
-- @param tp: type of the shape. (rect/circ)
------------------------------------------------
function jcslove_gameobject:SetShapeType(tp)
   self.shape.shapeType = tp

   if tp ~= "circ" and
      tp ~= "rect"
   then
      jcslove_debug.Error("Set the wrong shape for gameobject...")
   end
end

------------------------------------------------
-- Return the shape
------------------------------------------------
function jcslove_gameobject:GetShapeType()
   return self.shape.shapeType
end
