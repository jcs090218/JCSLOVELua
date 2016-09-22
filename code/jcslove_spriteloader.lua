-- ========================================================================
-- $File: jcslove_spriteloader.lua $
-- $Date: 2016-09-09 10:57:01 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


jcslove_spriteloader = {}

------------------------------------------------
-- Load the sprite from the path.
------------------------------------------------
-- @param filePath: path of the sprite we want to load.
-- @return sprite: sprite loaded into buffer.
------------------------------------------------
function jcslove_spriteloader.LoadSprite(filePath)
   local sprite = love.graphics.newImage(filePath)
   return sprite
end
