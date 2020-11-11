-- ========================================================================
-- $File: jcslove_math.lua $
-- $Date: 2016-09-12 03:39:51 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')


jcslove_math = {}

------------------------------------------------
-- Find the 3 side using pythagorean threorem
------------------------------------------------
-- @param s1: side 1
-- @param s2: side 2
-- @param tp : type
--          * opp, adj, hyp
------------------------------------------------
function jcslove_math.PythTheo(s1, s2, tp)

   if tp == "opp" or
      tp == "adj"
   then
      -- c^2 - b^2 = a^2
      local c = math.pow(s1, 2)
      local b = math.pow(s2, 2) -- a or b

      local sub = math.abs(c - b)

      return math.sqrt(sub)
   elseif tp == "hyp" then
      -- a^2 + b^2 = c^2
      local a = math.pow(s1, 2)
      local b = math.pow(s2, 2)

      return math.sqrt(a + b)
   else
      jcslove_debug.Error("enter type error...")
   end

end


------------------------------------------------
-- Calculates the dot product of a pair of vectors.
--
-- SOURCE: https://gist.github.com/Xeoncross/9511295
------------------------------------------------
-- @param a:
-- @param b:
------------------------------------------------
function jcslove_math.dotProduct(a, b)
   return a.x*b.x + a.y*b.y + (a.z or 0)*(b.z or 0)
end

------------------------------------------------
-- Calculates the cross product of a vector.
--
-- SOURCE: https://gist.github.com/Xeoncross/9511295
------------------------------------------------
-- @param a:
-- @param b:
------------------------------------------------
function jcslove_math.crossProduct(a, b)
   local x, y, z
   x = a.y * (b.z or 0) - (a.z or 0) * b.y
   y = (a.z or 0) * b.x - a.x * (b.z or 0)
   z = a.x * b.y - a.y * b.x

   return { x=x, y=y, z=z }
end

------------------------------------------------
-- Convert Degree to Radians
--
-- Formula: radians = degree * pi / 180
------------------------------------------------
function jcslove_math.DegreeToRadian(deg)
   return deg * math.pi / 180
end

------------------------------------------------
-- Convert Radians to Degree
--
-- Formula: degree = radians * 180 / pi
------------------------------------------------
function jcslove_math.RadianToDegree(rad)
   return rad * 180 / math.pi
end
