-- ========================================================================
-- $File: jcslove_camera.lua $
-- $Date: 2016-09-17 16:02:14 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- Simulate the 2d Camera in the game
-- First track

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_scenemanager')


jcslove_camera =
   {
      x = 0,
      y = 0,

      localX = 0,
      localY = 0,

      -- NOTE(jenchieh): current scene we are rendering
      -- and do the calculation math in order
      -- to simulate the camera movement.
      currentScene = nil,

      target = nil,     -- target we are following.
      targets = nil,        -- targets we are following. (array)

      -- Multiple Target??
      multiTarget = false,

   }


jcslove_camera.__index = jcslove_camera


local instance = nil

------------------------------------------------
-- Singleton Pattern
------------------------------------------------
function jcslove_camera.GetInstance()

   -- singleton pattern
   if instance == nil then
      instance = jcslove_camera:new()
   end

   return instance
end

------------------------------------------------
-- Private Constructor
------------------------------------------------
function jcslove_camera.new(init)
   -- STUDY(jenchieh): private constructor in lua.

   local newCamera = {}
   setmetatable(newCamera, jcslove_camera)

   newCamera.targets = {}

   return newCamera
end

------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_camera:update(dt)
   -- Do the math here.

   if self.multiTarget then
      -- Do multi target.

   else
      -- Do Single target.

   end
end
