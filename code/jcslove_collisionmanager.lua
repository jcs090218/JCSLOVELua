-- ========================================================================
-- $File: jcslove_collisionmanager.lua $
-- $Date: 2016-09-19 06:58:13 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- DESCRIPTION:

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')


jcslove_collisionmanager =
   {
      -- Get all the collider object
      -- in the game scene
      currentScene = nil,
   }


jcslove_collisionmanager.__index = jcslove_collisionmanager

local instance = nil

------------------------------------------------
-- Singleton Pattern
------------------------------------------------
function jcslove_collisionmanager.GetInstance()
   if instance == nil then
      instance = jcslove_collisionmanager:new()
   end

   return instance
end

------------------------------------------------
-- Private Constructor
------------------------------------------------
function jcslove_collisionmanager.new(init)
   local newCollisionManager = {}
   setmetatable(newCollisionManager, jcslove_collisionmanager)

   return newCollisionManager
end

------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_collisionmanager:update(dt)

end
