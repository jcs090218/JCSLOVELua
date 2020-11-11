-- ========================================================================
-- $File: jcslove_soundmanager.lua $
-- $Date: 2016-09-29 13:40:13 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')

jcslove_soundmanager =
   {
      sounds = nil,

      bgm_volume = 1, -- 0 ~ 1
      sfx_volume = 1,

      -- current bgm
      bgm = nil,

      -- back buffer bgm
      backBgm = nil,
   }


jcslove_soundmanager.__index = jcslove_soundmanager

-- sound manager instance.
local instance = nil

------------------------------------------------
-- Singleton Pattern
------------------------------------------------
function jcslove_soundmanager.GetInstance()

   -- assign new one if is null
   if instance == nil then
      instance = jcslove_soundmanager:new()
   end

   return instance
end

------------------------------------------------
-- Private Constructor
------------------------------------------------
function jcslove_soundmanager.new(init)
   local newSoundManager = {}
   setmetatable(newSoundManager, jcslove_soundmanager)

   -- create the sound buffer array here.
   newSoundManager.sounds = {}

   return newSoundManager
end

------------------------------------------------
-- Play one shot of the sound.
------------------------------------------------
-- @param fileName: File u want to load
-- @param ext: extension of the file.
------------------------------------------------
function jcslove_soundmanager:PlayOneShot(fileName, ext)
   local fullPath = fileName .. ext

   -- NOTE(jenchieh): only play it once.
   -- NOTE(love 2d): the "static" tells LÖVE to
   -- load the file into memory, good for short
   -- sound effects
   local sound = love.audio.newSource(fullPath, "static")

   -- Settings
   sound:setVolume(self.bgm_volume)

   -- play the sound.
   sound:play()
end

------------------------------------------------
-- Play the background music
--
-- NOTE(jenchieh: is good when u only have
-- one scene in your game! It wont work if
-- u try to switch scene.
------------------------------------------------
-- @param fileName: file name
-- @param ext: extension
------------------------------------------------
function jcslove_soundmanager:PlayBGM(fileName, ext)


   if self.bgm ~= nil then
      self.bgm:stop()
      self.bgm = nil
   end

   -- get the full path
   local fullPath = fileName .. ext

   -- NOTE(love 2d): if "static" is omitted, LÖVE will
   -- stream the file from disk, good for longer
   -- music tracks
   self.bgm = love.audio.newSource(fullPath)

   -- Settings
   self.bgm:setLooping(true)
   self.bgm:setVolume(self.bgm_volume)

   -- play the music.
   self.bgm:play()
end

------------------------------------------------
-- Change the back buffer to current buffer
------------------------------------------------
function jcslove_soundmanager:SwitchBackBuffer()

   -- stop the sound first
   self.bgm:stop()

   -- get the back BGM buffer
   self.bgm = self.backBgm

   -- set it to nil
   self.backBgm = nil

   -- Settings
   self.bgm:setLooping(true)
   self.bgm:setVolume(self.bgm_volume)

   -- play the background music.
   self.bgm:play()
end

------------------------------------------------
-- Load the sound into back buffer.
-- Wait for next scene is loaded.
------------------------------------------------
-- @param fileName: file name
-- @param ext: extension
------------------------------------------------
function jcslove_soundmanager:SetBGMForNextScene(fileName, ext)
   -- get the full path
   local fullPath = fileName .. ext

   -- load into back buffer
   self.backBgm = love.audio.newSource(fullPath)

   -- set volume to zero
   self.backBgm:setVolume(0)
end

------------------------------------------------
-- Set the background music sound volume.
------------------------------------------------
-- @param vol: sound volume
------------------------------------------------
function jcslove_soundmanager:SetBGMVolume(vol)

   -- set the manager bgm_volume
   self.bgm_volume = vol


   -- dont let the sound overflow the range.
   if self.bgm_volume < 0 then
      self.bgm_volume = 0
   elseif self.bgm_volume > 1 then
      self.bgm_volume = 1
   end

   -- set the actual sound buffer's bgm_volume.
   self.bgm:setVolume(self.bgm_volume)
end

------------------------------------------------
-- Set the sound effect sound volume.
------------------------------------------------
-- @param vol: sound volume
------------------------------------------------
function jcslove_soundmanager:SetSFXVolume(vol)

   -- set the manager bgm_volume
   self.sfx_volume = vol


   -- dont let the sound overflow the range.
   if self.sfx_volume < 0 then
      self.sfx_volume = 0
   elseif self.sfx_volume > 1 then
      self.sfx_volume = 1
   end

   -- TODO(jencheih): design sfx buffer.
   -- set the actual sound buffer's bgm_volume.
   --self.bgm:setVolume(self.bgm_volume)
end
