-- ========================================================================
-- $File: jcslove_camera.lua $
-- $Date: 2016-09-17 16:02:14 $
-- $Revision: 1.3.0 $
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

      recordX = 0,
      recordY = 0,

      -- NOTE(jenchieh): current scene we are rendering
      -- and do the calculation math in order
      -- to simulate the camera movement.
      currentScene = nil,

      target = nil,     -- target we are following.
      targets = nil,        -- targets we are following. (array)

      -- Multiple Target??
      multiTarget = false,

      velocity = ni,
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
   newCamera.velocity =
      {
         x = 0,
         y = 0,
      }

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

   -- Get the current scene and
   -- check if nil.
   self.currentScene = jcslove_scenemanager:GetInstance():GetCurrentScene()
   if self.currentScene == nil then
      return
   end


   local deltaSpeedX = self.velocity.x * dt
   local deltaSpeedY = self.velocity.y * dt

   -- real position
   self.x = self.x + deltaSpeedX
   self.y = self.y + deltaSpeedY

   -- macro to make camera work
   self.recordX = self.recordX + deltaSpeedX
   self.recordY = self.recordY + deltaSpeedY

   for index = 1, self.currentScene.length do

      -- Get the interface in the current
      -- rendering scene
      local interface = self.currentScene.interfaces[index]

      local renderObjCounter = 0

      for innerIndex = 1, interface.length do
         -- get the renderobject in the interface
         local renderObj = interface.renderObjects[innerIndex]

         -- apply position
         renderObj.x = renderObj.x - (self.recordX * math.abs(interface.friction))
         renderObj.y = renderObj.y - (self.recordY * math.abs(interface.friction))

      end -- end innerIndex loop

   end -- end index loop

   -- reset force
   self.recordX = 0
   self.recordY = 0

end

------------------------------------------------
-- Update the graphic layer.
------------------------------------------------
function jcslove_camera:draw()

end

------------------------------------------------
-- Set the camera position
------------------------------------------------
-- @param poX: position x
-- @param poY: position y
------------------------------------------------
function jcslove_camera:SetPositionXY(posX, posY)

   local difX = posX - self.x
   local difY = posY - self.y

   for index = 1, self.currentScene.length do

      -- Get the interface in the current
      -- rendering scene
      local interface = self.currentScene.interfaces[index]

      local renderObjCounter = 0

      for innerIndex = 1, interface.length do
         -- get the renderobject in the interface
         local renderObj = interface.renderObjects[innerIndex]

         -- apply position
         renderObj.x = renderObj.x - (difX * math.abs(interface.friction))
         renderObj.y = renderObj.y - (difY * math.abs(interface.friction))

      end -- end innerIndex loop

   end -- end index loop

   -- set the macros
   self.x = posX
   self.y = posY

end
