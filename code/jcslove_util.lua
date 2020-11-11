-- ========================================================================
-- $File: jcslove_util.lua $
-- $Date: 2016-09-16 12:22:15 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_spriteloader')


jcslove_util = {}


------------------------------------------------
--
------------------------------------------------
--
------------------------------------------------
function jcslove_util.InBetween(vecA, vecB)

end

------------------------------------------------
-- Pass in the possiblity and see if go
-- through the possibility.
------------------------------------------------
function jcslove_util.IsPossible(chance)
   return chance > math.random(0, 100)
end

------------------------------------------------
-- To positive value
------------------------------------------------
-- @param val: value to positive
------------------------------------------------
function jcslove_util.ToPositive(val)
   return math.abs(val)
end

------------------------------------------------
-- To negative value
------------------------------------------------
-- @param val: value to negative
------------------------------------------------
function jcslove_util.ToNegative(val)
   return -math.abs(val)
end

------------------------------------------------
-- Simple Flip boolean function
------------------------------------------------
-- @param val: bool value
------------------------------------------------
function jcslove_util.FlipBool(val)

   -- Simple flip algorithm
   if val == true then
      val = false
   else
      val = true
   end

   -- and return it for more use.
   return val
end

------------------------------------------------
-- Create the Interface Sprite
------------------------------------------------
-- @param inter: interface object.
-- @param filePath: path of the sprite file.
------------------------------------------------
function jcslove_util.CreateInterfaceSprite(inter, filePath)

   -- load sprite
   local tempSprite = jcslove_spriteloader.LoadSprite(filePath)

   -- create game object
   local spriteObj = jcslove_gameobject:new()

   -- set sprite to the game object that just created.
   spriteObj:SetSpriteSprite(tempSprite)

   -- auto pivot the sprite
   spriteObj.sprite:AutoPivot()

   -- add to the background
   inter:add(spriteObj)

   return spriteObj
end


------------------------------------------------
-- Create the Interface Animation
------------------------------------------------
-- @param inter: interface object.
-- @param filePath: path of the sprite file.
-- @param baseName: base name of the animation
-- @param ext: extension
-- @param frameCount: frame count
------------------------------------------------
function jcslove_util.CreateInterfaceAnimation(inter, filePath, baseName, ext, frameCount)

   -- create the instance
   local tempAnimObj = jcslove_gameobject:new()

   -- load animation
   tempAnimObj.animation:CreateSpriteSequence(
      filePath,
      baseName,
      ext,
      frameCount)

   -- pivot the animation
   tempAnimObj.animation:AutoPivot()

   -- add to the background
   inter:add(tempAnimObj)

   return tempAnimObj
end
