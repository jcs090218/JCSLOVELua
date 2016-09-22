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
require (_PACKAGE .. '/jcslove_debug')


jcslove_animation =
   {
      x = 0,  -- animation position x
      y = 0,  -- animation position y

      frame = 0,  -- current frame we are rendering
      frameCount = 0,  -- total frame count

      timer = 0,
      timePerFrame = 0.1,   -- time for each frame to render

      sprites = {},   -- sequence of sprite
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

   return newAnim
end

------------------------------------------------
-- Update game logic here.
------------------------------------------------
function jcslove_animation:update(dt)

   -- Do not increse the frame count,
   -- if the animation is pause.
   if pause == false then
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
   if self.frame >= self.frameCount and
      self.loop == true
   then
      self.frame = 0
   end

end

------------------------------------------------
-- Render graphics here.
------------------------------------------------
function jcslove_animation:draw()


   -- frame count check.
   if self.frame >= self.frameCount then
      return
   end

   -- NOTE(JenChieh):
   -- render.position = animation.position + gameobject.position

   love.graphics.draw(
      self.sprites[self.frame],
      self.x + self.gameObject.x,
      self.y + self.gameObject.y)
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

   for index = 0, frameCount - 1 do
      local bn = filePath .. baseName .. index .. ext;

      self.sprites[index] = jcslove_spriteloader.LoadSprite(bn)
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
   self.frame = 0

   -- reset self.timer
   self.timer = 0

   -- Lastly, play the animation.
   jcslove_animation:Play()
end

------------------------------------------------
-- Pause the animation in current frame
------------------------------------------------
function jcslove_animation:Pause()
   -- make render equl to false,
   -- will make the animation stop render.
   pause = true
end

------------------------------------------------
-- Play the animation in the current frame.
------------------------------------------------
function jcslove_animation:Play()
   -- start the animation.
   pause = false
end
