-- ========================================================================
-- $File: jcslove_collisionmanager.lua $
-- $Date: 2016-09-19 06:58:13 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- DESCRIPTION: Suppose to handle the wall, etc.
-- not for handling the player, etc.

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_collision')


jcslove_collisionmanager =
   {
      -- Get all the collider object
      -- in the game scene
      currentScene = nil,

      -- Array of collider, it could be
      -- shape or collision.
      colliders = nil,
      collidersType = nil,

      length = 0,
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

   newCollisionManager.colliders = {}
   newCollisionManager.collidersType = {}

   return newCollisionManager
end

------------------------------------------------
-- Add collider
------------------------------------------------
function jcslove_collisionmanager:Add(col, colType)
   self.length = self.length + 1

   -- check collider type
   if colType ~= "circ" and
      colType ~= "rect"
   then
      jcslove_debug.Error("Wrong Collider type pass in...")
      return
   end

   self.colliders[self.length] = col
   self.collidersType[self.length] = colType
end

------------------------------------------------
-- Check collider
------------------------------------------------
-- @param obj: object u want want to check
-- @param shape: what kind of shape are this object?
------------------------------------------------
function jcslove_collisionmanager:CheckCollide(obj, shape)

   if shape == "circ" then

      for index = 1, self.length do
         local col = self.colliders[index]
         local colType = self.collidersType[index]

         if colType == "circ" then

            -- Both circle
            if jcslove_collision.CircleToCircle(obj, col) then
               return true
            end

         elseif colType == "rect" then

            -- pass in circle
            -- manager rect.
            if jcslove_collision.RectToCircle(col, obj) then
               return true
            end

         end

      end

   elseif shape == "rect" then

      for index = 1, self.length do
         local col = self.colliders[index]
         local colType = self.collidersType[index]

         if colType == "circ" then

            -- if pass in rect
            -- col is circle
            if jcslove_collision.RectToCircle(obj, col) then
               return true
            end

         elseif colType == "rect" then

            -- if both rect
            if jcslove_collision.RectToRect(col, obj) then
               return true
            end

         end

      end

   else
      jcslove_debug.Error("Wrong Check Type...")

   end

   return false
end
