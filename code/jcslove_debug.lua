-- ========================================================================
-- $File: jcslove_debug.lua $
-- $Date: 2016-09-10 15:30:42 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


jcslove_debug =
   {
      -- global macros
      DEBUG = true


   }

DEBUG_COLOR =
   {
      r = 127,
      g = 127,
      b = 127,
      a = 127,
   }


------------------------------------------------
-- Set the color to debug color set.
------------------------------------------------
function jcslove_debug.DebugColor()

   love.graphics.setColor(
      DEBUG_COLOR.r,
      DEBUG_COLOR.g,
      DEBUG_COLOR.b,
      DEBUG_COLOR.a)
end

------------------------------------------------
-- Print out the Error Log
------------------------------------------------
-- @param str: message to print
------------------------------------------------
function jcslove_debug.Error(str)
   print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
   print("Error: " .. str)
   print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end

------------------------------------------------
-- Print out the Warning Log
------------------------------------------------
-- @param str: message to print
------------------------------------------------
function jcslove_debug.Warning(str)
   print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
   print("Warnging: " .. str)
   print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end

------------------------------------------------
-- Print out the Informational Log
------------------------------------------------
-- @param str: message to print
------------------------------------------------
function jcslove_debug.Informational(str)
   print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
   print("Informational: " .. str)
   print("=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")
end
