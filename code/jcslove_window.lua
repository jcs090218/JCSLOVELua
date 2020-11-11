-- ========================================================================
-- $File: jcslove_window.lua $
-- $Date: 2016-09-11 05:10:20 $
-- $Revision: 1.3.0 $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


--- Flags Source:
---         - https://love2d.org/wiki/love.window.setMode

jcslove_window = {}

local m_windowTitle = "JCSLOVELua_Framework"

------------------------------------------------
-- Set Window Title
------------------------------------------------
-- @param title: window title
------------------------------------------------
function jcslove_window.SetTitle(title)

   -- make sure to record down the title.
   m_windowTitle = title

   -- make request to Love2d engine.
   love.window.setTitle(title)
end

------------------------------------------------
-- Set window Width
------------------------------------------------
-- @param w: window width
------------------------------------------------
function jcslove_window.Width(w)

   local tempH = love.graphics.getHeight()

   love.window.setMode(w, tempH)
end

------------------------------------------------
-- Set window Height
------------------------------------------------
-- @param h: window height
------------------------------------------------
function jcslove_window.Height(h)

   local tempW = love.graphics.getWidth()

   love.window.setMode(tempW, h)
end

------------------------------------------------
-- Set the width and height at the same time
------------------------------------------------
-- @param w: width of the screen buffer
-- @param h: height of the screen buffer
------------------------------------------------
function jcslove_window.SetScreenSize(w, h)
   love.window.setMode(w, h)
end

------------------------------------------------
-- Trigger Resizable window
------------------------------------------------
-- @param act: set window resizable?
------------------------------------------------
function jcslove_window.Resizable(act)

   -- get the temporary window rect
   local windowRect = jcslove_window.WindowInfo()

   -- set the resizable
   love.window.setMode(
      windowRect.width,
      windowRect.height,
      {
         -- flags
         resizable = act
      }
   )
end

------------------------------------------------
-- Get the Window Information
------------------------------------------------
-- @return table: window information
-- 1) title
-- 2) width and height
------------------------------------------------
function jcslove_window.WindowInfo()
   return
      {
         title = m_windowTitle,
         width = love.graphics.getWidth(),
         height = love.graphics.getHeight()
      }
end

------------------------------------------------
-- Set the vsync
------------------------------------------------
-- @param act: boolean turning vsync on/off.
------------------------------------------------
function jcslove_window.SetVsync(act)

   -- get the temporary window rect
   local windowRect = jcslove_window.WindowInfo()

   -- set the resizable
   love.window.setMode(
      windowRect.width,
      windowRect.height,
      {
         -- flags
         vsync = act
      }
   )
end

------------------------------------------------
-- Output the message box (Cross Platform)
------------------------------------------------
-- @param title: title of the message box
-- @param message: message inside the message box
-- @param type: type of the message box
-- @param attachtowindow: Whether the message box should
-- be attached to the love window or free-floating.
------------------------------------------------
function jcslove_window.MessageBox(title, message, type, attachtowindow)
   -- NOTE(JenChieh): Simply wrap over the function
   -- call from love 2d engine.
   return love.window.showMessageBox(title, message, type, attachtowindow)
end
