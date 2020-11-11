-- ========================================================================
-- $File: jcslove_scenemanager.lua $
-- $Date: 2016-09-16 13:48:05 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')


-- Manage multiple scene in order to switch scene.

jcslove_scenemanager =
   {
      -- scene to manage and ready to be loaded.
      scenes = nil,

      length = 0,
   }

jcslove_scenemanager.__index = jcslove_scenemanager

-- NOTE(JenChieh): do not manully set this to nil...
local instance = nil

-- FadOut/FadeIn the scene
local g_fadeState = "empty"

-- conbine fade in and out time.
local g_fadeSpeed = 2 * 100

local g_loadScene = false

local g_currentScene = nil
local g_backScene = nil


------------------------------------------------
-- Singleton Pattern
------------------------------------------------
function jcslove_scenemanager.GetInstance()

   -- assign new one if is null
   if instance == nil then
      instance = jcslove_scenemanager:new()
   end

   return instance
end

------------------------------------------------
-- Private Constructor
------------------------------------------------
function jcslove_scenemanager.new(init)
   local newSceneManager = {}
   setmetatable(newSceneManager, jcslove_scenemanager)

   newSceneManager.scenes = {}

   return newSceneManager
end

------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_scenemanager:update(dt)

   if g_currentScene == nil then
      return
   end

   -- do fading.
   jcslove_scenemanager:FadeScene(
      g_fadeState,
      dt)

   -- update the logic current scene
   g_currentScene:update(dt)
end

------------------------------------------------
-- Update graphics
------------------------------------------------
function jcslove_scenemanager:draw()

   if g_currentScene == nil then
      return
   end

   -- update the graphic current scene
   g_currentScene:draw()
end


------------------------------------------------
-- Switch the scene by scene name,
-- use it when u have it in the buffer.
------------------------------------------------
-- @param sceneName: name of the scene
------------------------------------------------
-- function jcslove_scenemanager:SwitchScene(sceneName)

-- end

------------------------------------------------
-- Switch the scene by passing the scene pointer.
------------------------------------------------
-- @param sceneObj: scene object
------------------------------------------------
function jcslove_scenemanager:SwitchScene(sceneObj)

   -- check pass in value
   if sceneObj == nil then
      jcslove_debug.Error("Pass in scene that are nil...")
      return
   end

   if g_fadeState ~= "empty" then
      jcslove_debug.Informational("Scene is still loading...")
      return
   end

   if g_currentScene ~= nil then
      -- fade out the scene if the
      -- previous scene isn't null
      g_fadeState = "fadeout"
   else

      -- set the scene directly, probably the first time
      -- assign the scene.
      g_currentScene = sceneObj

      -- TEMPORARY(jenchieh): weird bug...
      --g_fadeState = "fadein"
   end

   -- record down the scene
   g_backScene = sceneObj
   g_loadScene = true

end

------------------------------------------------
-- Add a scene into buffer, so we can ready to loaded.
-- NOTE(JenChieh): this is optional.
------------------------------------------------
-- @param sceneObj: scene load into buffer.
------------------------------------------------
function jcslove_scenemanager:add(sceneObj)

   -- add the renderable object in to queue
   self.scenes[self.length] = sceneObj

   -- add one length
   self.length = self.length + 1
end

------------------------------------------------
-- Loop through the whole scene's object
-- and set the color out.
------------------------------------------------
-- @param tp: fade in/out.
-- @param dt: delta time..
------------------------------------------------
function jcslove_scenemanager:FadeScene(tp, dt)

   -- Cannot do stuff without
   -- current scene assign
   if g_currentScene == nil then
      return
   end

   -- Stop the sound
   local soundmanager = jcslove_soundmanager:GetInstance()

   -- count the alpha is empty
   local interfaceCounter = 0

   -- do fade out
   if tp == "fadeout" then

      -- Fadout the sound
      soundmanager:SetBGMVolume(soundmanager.bgm_volume - dt)

      for index = 1, g_currentScene.length do

         -- Get the interface in the current
         -- rendering scene
         local interface = g_currentScene.interfaces[index]

         local renderObjCounter = 0

         for innerIndex = 1, interface.length do
            -- get the renderobject in the interface
            local renderObj = interface.renderObjects[innerIndex]

            -- minus the alpha by time
            renderObj.color.a = renderObj.color.a - (dt * g_fadeSpeed)

            -- add one to counter
            if renderObj.color.a <= 0 then
               renderObjCounter = renderObjCounter + 1
               renderObj.color.a = 0
            end
         end

         -- If the same length meaning this
         -- interface is completely invisible.
         if renderObjCounter == interface.length then
            interfaceCounter = interfaceCounter + 1
         end

      end


      -- check the counter and interface invisible or not?
      if interfaceCounter == g_currentScene.length then
         -- Every interface is invisible now!

         -- change the state
         g_fadeState = "empty"

         if g_loadScene then
            -- load back scene buffer into current buffer.
            g_currentScene = g_backScene

            -- fade in again
            g_fadeState = "fadein"


            -- turn all color alpha to zero
            for index = 1, g_currentScene.length do

               -- Get the interface in the current
               -- rendering scene
               local interface = g_currentScene.interfaces[index]

               for innerIndex = 1, interface.length do
                  -- get the renderobject in the interface
                  local renderObj = interface.renderObjects[innerIndex]

                  -- minus the alpha by time
                  renderObj.color.a = 0
               end -- end innerIndex loop
            end -- end index loop


            -- switch the back buffer to current buffer
            -- and play it!
            soundmanager:SwitchBackBuffer()

            -- Reset our camera
            local camera = jcslove_camera:GetInstance()
            camera:SetPositionXY(0, 0)

         end

      end

      -- do fade in
   elseif tp == "fadein" then

      -- Fade in the sound
      soundmanager:SetBGMVolume(soundmanager.bgm_volume + dt)

      for index = 1, g_currentScene.length do

         -- Get the interface in the current
         -- rendering scene
         local interface = g_currentScene.interfaces[index]

         local renderObjCounter = 0

         for innerIndex = 1, interface.length do
            -- get the renderobject in the interface
            local renderObj = interface.renderObjects[innerIndex]

            -- minus the alpha by time
            renderObj.color.a = renderObj.color.a + (dt * g_fadeSpeed)

            -- add one to counter
            if renderObj.color.a >= 255 then
               renderObjCounter = renderObjCounter + 1
               renderObj.color.a = 255
            end
         end

         -- If the same length meaning this
         -- interface is completely visible.
         if renderObjCounter == interface.length then
            interfaceCounter = interfaceCounter + 1
         end
      end

      -- check the counter and interface visible or not?
      if interfaceCounter == g_currentScene.length then
         -- Every interface is visible now!

         -- change the state
         g_fadeState = "empty"

         -- done loading scene
         g_loadScene = false
      end

   elseif tp == "empty" then
      -- default.
   else
      jcslove_debug.Error("Fade in/out pass in the wrong type...")
   end

end

------------------------------------------------
-- Return Current Scene Object
------------------------------------------------
-- @return sceneObj: return current scene object.
------------------------------------------------
function jcslove_scenemanager.GetCurrentScene()
   return g_currentScene
end
