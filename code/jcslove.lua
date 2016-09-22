-- ========================================================================
-- $File: jcslove.lua $
-- $Date: 2016-09-10 11:34:10 $
-- $Revision: $
-- $Creator: Jen-Chieh Shen $
-- $Notice: See LICENSE.txt for modification and distribution information $
--                   Copyright (c) 2016 by Shen, Jen-Chieh $
-- ========================================================================


jcslove = {}

-- pre loader file --

local _PACKAGE = (...):match("^(.+)[%./][^%./]+") or ""


-- object utililties
require (_PACKAGE .. '/jcslove_interface')
require (_PACKAGE .. '/jcslove_scene')
require (_PACKAGE .. '/jcslove_scenemanager')
require (_PACKAGE .. '/jcslove_collisionmanager')
require (_PACKAGE .. '/jcslove_camera')

-- device utilities
require (_PACKAGE .. '/jcslove_spriteloader')
require (_PACKAGE .. '/jcslove_collision')
require (_PACKAGE .. '/jcslove_color')
require (_PACKAGE .. '/jcslove_debug')
require (_PACKAGE .. '/jcslove_window')
require (_PACKAGE .. '/jcslove_math')
require (_PACKAGE .. '/jcslove_util')
require (_PACKAGE .. '/jcslove_input')

-- object services
require (_PACKAGE .. '/jcslove_gameobject')
require (_PACKAGE .. '/jcslove_sprite')
require (_PACKAGE .. '/jcslove_animation')
require (_PACKAGE .. '/jcslove_shape')

------------------------------------------------
-- Global initialize function for framework
------------------------------------------------
function jcslove.init()
   jcslove_window.SetTitle("JCSLOVELua_Framework")

   -- make the time random
   math.randomseed(os.time())

   -- default in the framework, depends on author
   -- preferences decision.
   jcslove_window.Resizable(false)
   jcslove_window.SetScreenSize(1280, 720)

end
