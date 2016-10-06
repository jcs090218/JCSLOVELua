-- ========================================================================
-- $File: jcslove_animator.lua $
-- $Date: 2016-09-25 11:19:25 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- DESCRIPTION:

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_animation')


jcslove_animator =
   {
      gameObject = nil,

      -- NOTE(jenchieh): Array of
      -- animation that animator going
      -- to handle
      animations = nil,

      -- Store the current animation
      currentAnimation = nil,

      -- length of the animations array
      length = 0,
   }


jcslove_animator.__index = jcslove_animator


------------------------------------------------
-- Constructor
------------------------------------------------
function jcslove_animator.new(init, gameObject)
   local newAnimator = {}
   setmetatable(newAnimator, jcslove_animator)

   newAnimator.gameObject = gameObject
   newAnimator.animations = {}

   return newAnimator
end

------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_animator:update(dt)

   -- Check even the animation exist?
   if self.currentAnimation == nil then
      return
   end

   -- update the current animation
   self.currentAnimation:update(dt)
end

------------------------------------------------
-- Update graphics
------------------------------------------------
function jcslove_animator:draw()

   -- Check even the animation exist?
   if self.currentAnimation == nil then
      return
   end

   -- draw the current animation
   self.currentAnimation:draw()
end

------------------------------------------------
-- Switch the animation by index.
--
-- NOTE(jenchieh): call when u want to switch
-- the animation.
------------------------------------------------
function jcslove_animator:SwitchAnimation(index)

   -- Check index in the range.
   if self.animations[index] == nil then
      jcslove_debug.Error(
         "Animation index u pass in does not found...");

      return
   end

   -- set the current animation
   self.currentAnimation = self.animations[index]
end

------------------------------------------------
-- Create a animation and add it into
-- animator system.
------------------------------------------------
-- @param filePath: file path
-- @param baseName: base name of the animation
-- @param ext: extension
-- @param frameCount: frame count
------------------------------------------------
function jcslove_animator:AddAndCreateSpriteSequence(filePath, baseName, ext, frameCount)
   -- Create a new instance animation
   local newAnim = jcslove_animation:new(self.gameObject)

   -- Create the animation
   newAnim:CreateSpriteSequence(filePath, baseName, ext, frameCount)

   -- add the aniamtion into animations array.
   self:AddAnimation(newAnim)
end

------------------------------------------------
-- Add the current existing animation
-- to the aniamtor.
------------------------------------------------
-- @param anim: current existing animation.
------------------------------------------------
function jcslove_animator:AddAnimation(anim)
   -- increase the animation length.
   self.length = self.length + 1

   self.animations[self.length] = anim
end

------------------------------------------------
-- Auto set the pivot to center
--
-- NOTE(jenchieh): only when the sprite are
-- right left or top down the same will be
-- good to use of this function call.
------------------------------------------------
function jcslove_animator:AutoPivot()

   -- Loop through all the sprite and set the pivot
   for index = 1, self.length do
      self.animations[index]:AutoPivot()
   end

end

------------------------------------------------
-- Flip X all the sprite in this animation?
------------------------------------------------
function jcslove_animator:FlipX(act)
   -- Loop through all the sprite and set the flipX
   for index = 1, self.length do
      self.animations[index]:FlipX(act)
   end
end

------------------------------------------------
-- Flip Y all the sprite in this animation?
------------------------------------------------
function jcslove_animator:FlipY(act)
   -- Loop through all the sprite and set the flipY
   for index = 1, self.length do
      self.animations[index]:FlipY(act)
   end
end
