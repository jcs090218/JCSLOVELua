-- ========================================================================
-- $File: jcslove_scene.lua $
-- $Date: 2016-09-16 13:27:11 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- Handle array of interface in order to do
-- switch scene effect.

jcslove_scene =
   {
      -- NOTE(JenChieh): 先把array設成nil
      interfaces = nil,      -- interface array

      length = 0,

      -- name of the scene, in order to do switch scene.
      name = "",
   }

jcslove_scene.__index = jcslove_scene

------------------------------------------------
-- Constructor
------------------------------------------------
function jcslove_scene.new(init)
   local newScene = {}
   setmetatable(newScene, jcslove_scene)

   -- NOTE(jenchieh): 這個地方太誇張了.
   -- 一定得要這樣做才能做一個自己的array
   -- 否則會共用記憶體,所以會被override.
   newScene.interfaces = {}

   return newScene
end

------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_scene:update(dt)

   for index = 1, self.length do
      self.interfaces[index]:update(dt)
   end

end

------------------------------------------------
-- Update graphics
------------------------------------------------
function jcslove_scene:draw()

   for index = 1, self.length do
      self.interfaces[index]:draw()
   end

end

------------------------------------------------
-- Add a interface object into this scene.
------------------------------------------------
-- @param inter: interface u want to add to render.
------------------------------------------------
function jcslove_scene:add(inter)

   -- add one length
   self.length = self.length + 1

   -- add the renderable object in to queue
   self.interfaces[self.length] = inter

   print(self.interfaces)

end

------------------------------------------------
-- Remove the interface object from this scene.
------------------------------------------------
-- @param inter: interface u want to remove
-- from the render.
------------------------------------------------
function jcslove_scene:remove(inter)
   -- TODO(JenChieh): remove the interface from the array.
end
