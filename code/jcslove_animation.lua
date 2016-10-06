-- ========================================================================
-- $File: jcslove_animation.lua $
-- $Date: 2016-09-12 04:36:04 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_spriteloader')
require (_PACKAGE .. '/jcslove_sprite')
require (_PACKAGE .. '/jcslove_debug')


jcslove_animation =
   {
      x = 0,  -- animation position x
      y = 0,  -- animation position y

      frame = 1,  -- current frame we are rendering
      frameCount = 0,  -- total frame count

      timer = 0,
      timePerFrame = 0.1,   -- time for each frame to render

      sprites = nil,   -- sequence of sprite
      loop = true,   -- loop the animation or not?

      gameObject = nil,

      pause = false, -- pause the animation?
   }



jcslove_animation.__index = jcslove_animation

------------------------------------------------
-- Constructor
------------------------------------------------
-- @param filePath: file path
-- @param baseName: file base name
-- @param ext: extension
-- @param frameCount: frame count.
------------------------------------------------
function jcslove_animation.new(init, gameObject)
   local newAnim = {}
   setmetatable(newAnim, jcslove_animation)

   newAnim.gameObject = gameObject
   newAnim.sprites = {}

   return newAnim
end

------------------------------------------------
-- Update game logic here.
------------------------------------------------
function jcslove_animation:update(dt)

   -- Do not increse the frame count,
   -- if the animation is pause.
   if self.pause == true then
      return
   end

   -- increase timer.
   self.timer = self.timer + dt

   -- check to increase next frame or not.
   if (self.timer < self.timePerFrame) then
      return
   end

   -- add one frame
   self.frame = self.frame + 1

   -- reset self.timer
   self.timer = 0
   -- reset frame back to zero.
   if self.frame > self.frameCount and
      self.loop == true
   then
      self.frame = 1
   end

end

------------------------------------------------
-- Render graphics here.
------------------------------------------------
function jcslove_animation:draw()


   -- frame count check.
   if self.frame > self.frameCount then
      return
   end

   self.sprites[self.frame]:draw()
end

------------------------------------------------
-- Create sequence of sprite and
-- load into the buffer.
------------------------------------------------
-- @param filePath: file path
-- @param baseName: base name of the animation
-- @param ext: extension
-- @param frameCount: frame count
------------------------------------------------
function jcslove_animation:CreateSpriteSequence(filePath, baseName, ext, frameCount)

   self.frameCount = frameCount

   for index = 1, frameCount do
      local bn = filePath .. baseName .. (index - 1) .. ext;

      local tempSprite = jcslove_spriteloader.LoadSprite(bn)
      self.sprites[index] = jcslove_sprite:new(self.gameObject)
      self.sprites[index]:SetSprite(tempSprite)
   end

end

------------------------------------------------
-- Play one shot of the animation.
--
-- NOTE: Call this when u want to play the animation
-- at the beginning of the frame.
------------------------------------------------
function jcslove_animation:PlayOneShot()

   -- reset frame
   self.frame = 1

   -- reset self.timer
   self.timer = 0

   -- Lastly, play the animation.
   self:Play()
end

------------------------------------------------
-- Pause the animation in current frame
------------------------------------------------
function jcslove_animation:Pause()
   -- make render equl to false,
   -- will make the animation stop render.
   self.pause = true
end

------------------------------------------------
-- Play the animation in the current frame.
------------------------------------------------
function jcslove_animation:Play()
   -- start the animation.
   self.pause = false
end

------------------------------------------------
-- Auto set the pivot to center
--
-- NOTE(jenchieh): only when the sprite are
-- right left or top down the same will be
-- good to use of this function call.
------------------------------------------------
function jcslove_animation:AutoPivot()

   -- Loop through all the sprite and set the pivot
   for index = 1, self.frameCount do
      self.sprites[index]:AutoPivot()
   end

end

------------------------------------------------
-- Flip X all the sprite in this animation?
------------------------------------------------
function jcslove_animation:FlipX(act)
   -- Loop through all the sprite and set the flipX
   for index = 1, self.frameCount do
      self.sprites[index].flipX = act
   end
end

------------------------------------------------
-- Flip Y all the sprite in this animation?
------------------------------------------------
function jcslove_animation:FlipY(act)
   -- Loop through all the sprite and set the flipY
   for index = 1, self.frameCount do
      self.sprites[index].flipY = act
   end
end
