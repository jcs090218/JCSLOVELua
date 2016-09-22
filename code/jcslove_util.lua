-- ========================================================================
-- $File: jcslove_util.lua $
-- $Date: 2016-09-16 12:22:15 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""
require (_PACKAGE .. '/jcslove_debug')


jcslove_util = {}


------------------------------------------------
--
------------------------------------------------
--
------------------------------------------------
function jcslove_util.InBetween(vecA, vecB)

end

------------------------------------------------
-- Pass in the possiblity and see if go
-- through the possibility.
------------------------------------------------
function jcslove_util.IsPossible(chance)
   return chance > math.random(0, 100)
end

------------------------------------------------
-- To positive value
------------------------------------------------
function jcslove_util.ToPositive(val)
   return math.abs(val)
end

------------------------------------------------
-- To negative value
------------------------------------------------
function jcslove_util.ToNegative(val)
   return -math.abs(val)
end
