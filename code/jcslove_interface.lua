-- ========================================================================
-- $File: jcslove_interface.lua $
-- $Date: 2016-09-09 11:32:49 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


-- * Render sequence of renderable object.
-- * Equals to one sorting order cost one
--  batch for one interface.


jcslove_interface =
   {
      -- NOTE(JenChieh): 先把array設成nil
      renderObjects = nil,

      x = 0,
      y = 0,

      localX = 0,
      localY = 0,

      length = 0,

      friction = 0,
   }

jcslove_interface.__index = jcslove_interface


------------------------------------------------
-- Constructor
------------------------------------------------
function jcslove_interface.new(init)
   local newInterface = {}
   setmetatable(newInterface, jcslove_interface)

   -- NOTE(jenchieh): 這個地方太誇張了.
   -- 一定得要這樣做才能做一個自己的array
   -- 否則會共用記憶體,所以會被override.
   newInterface.renderObjects = {}

   return newInterface
end

------------------------------------------------
-- Update logic
------------------------------------------------
-- @param dt: delta time
------------------------------------------------
function jcslove_interface:update(dt)

   for index = 1, self.length do

      -- get the current index renderable object
      self.renderObjects[index]:update(dt)

   end -- end for loop

end

------------------------------------------------
-- Update graphics
------------------------------------------------
function jcslove_interface:draw()


   for index = 1, self.length do

      -- do the draw
      self.renderObjects[index]:draw()

   end -- end for loop

end

------------------------------------------------
-- Add a renderable object into this interface.
------------------------------------------------
-- @param renderObj: object want to be render
--  in this layer of interface.
------------------------------------------------
function jcslove_interface:add(renderObj)

   -- add one length
   self.length = self.length + 1

   -- add the renderable object in to queue
   self.renderObjects[self.length] = renderObj

end
