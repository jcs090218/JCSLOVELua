-- ========================================================================
-- $File: jcslove_collision.lua $
-- $Date: 2016-09-09 14:59:10 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_math')

jcslove_collision = { }


------------------------------------------------
-- Some Shape acknoledge.
-- 1) Rectange contain
--       x : x position
--       y : y position
--       width : x position + width
--       height : y position + height
------
-- 2) Circle contain
--       x, y, radius
------


------------------------------------------------
-- Check collision detection with AABB
------------------------------------------------
-- @param rectA: rectangle A
-- @param rectB: rectangle B
------------------------------------------------
function jcslove_collision.RectToRect(rectA, rectB)

   if rectA.x + rectA.width > rectB.x and
      rectA.x < rectB.x + rectB.width and
      rectA.y + rectA.height > rectB.y and
      rectA.y < rectB.y + rectB.height
   then
      return true
   end

   return false
end

------------------------------------------------
-- Check collision circle and circle
------------------------------------------------
-- @param circA: circle A
-- @param circB: circle B
------------------------------------------------
function jcslove_collision.CircleToCircle(circA, circB)

   local distance = jcslove_collision.PointDistance(circA, circB)

   if distance < circA.radius + circB.radius then
      return true
   end

   return false
end

------------------------------------------------
-- Check collision rect and circle
--
-- SOURCE: https://www.zhihu.com/question/24251545
------------------------------------------------
-- @param rect: rectangle
-- @param circ: circle
------------------------------------------------
function jcslove_collision.RectToCircle(rect, circ)

   -- c为矩形中心
   local c  =
      {
         x = rect.x + rect.width / 2,
         y = rect.y + rect.height / 2
      }

   -- p为圆心
   local p =
      {
         x = circ.x,
         y = circ.y
      }

   local v =
      {
         x = jcslove_collision.OneDimension(c.x, p.x),
         y = jcslove_collision.OneDimension(c.y, p.y)
      }

   local side1 = math.abs(rect.x - (rect.x + rect.width))
   local side2 = math.abs(rect.y - (rect.y + rect.height))

   -- h为矩形半長
   local h =
      {
         x = side1 / 2,
         y = side2 / 2
      }

   local u =
      {
         x = math.max(v.x - h.x, 0),
         y = math.max(v.y - h.y, 0)
      }

   return jcslove_math.dotProduct(u, u) <= circ.radius * circ.radius
end

------------------------------------------------
-- Check if the point inside the circle range.
------------------------------------------------
-- @param point: point
-- @param circ: circle
------------------------------------------------
function jcslove_collision.PointToCircle(point, circ)

   local distance = jcslove_collision.PointDistance(point, circ)

   if distance < circ.radius then
      return true       -- inside the circle's radius
   end

   -- not inside.
   return false;
end

------------------------------------------------
-- Find the distance between point and point.
------------------------------------------------
-- @param pointA: point A
-- @param pointB: point B
------------------------------------------------
function jcslove_collision.PointDistance(pointA, pointB)

   -- find the two axis distance
   local vDistance = math.abs(pointA.x - pointB.x)
   local hDistance = math.abs(pointA.y - pointB.y)

   -- a^2 + b^2 = c^2
   return math.sqrt(math.pow(vDistance, 2) + math.pow(hDistance, 2))
end

------------------------------------------------
--
------------------------------------------------
function jcslove_collision.OneDimension(a, b)
   return math.abs(a - b)
end
