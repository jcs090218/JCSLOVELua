--[[Logger.lua]]
--[[Objectives:
   Handle errors with the --console output in lua
   Includes:
   Logger.log: for printing basic info to console at the Time:Level given
   Logger.warn: prints a warning to console at Time:Level given with "(!)" appended to front
   Logger.Error: Non ending error handling, Appends "ERROR: " appended to front
   Time and Date of the start.
   Ammount of Errors,Logs,And warnings logs
   Creator:
   Via Pruitt
   Modefied:
   Jen-Chieh Shen
]]

local Logger = {}
local assert, print, error = assert, print, error
local startTime = os.time()
local startDate = os.date()
local ErrorsLogged, LogsLogged, WarningsLogged = 0,0,0
--print("starting at "..startDate..": "..startTime)

Logger.__index = Logger --When any Logger is accessed, similar to get;
function Logger:__tostring()
   return("Logger: Logs all your issues and troubles!")
end
function Logger.__tostring()
   return("Logger: Logs all your issues and troubles!")
end

--[[Read only test, failed.]]
--Logger.__newindex = function() error(debug.getinfo(2).currentline.." You cannot add values to Logger!") end
--Logger[#Logger + 1] = "Test"
--print(Logger[#Logger])


--[[Returns <string> Containing current information being sent]]
local function currentInfo()
   local file = debug.getinfo(3).source --Filename returns files or [C]
   local line = debug.getinfo(3).currentline --Returns the line with the level specified, 1 should return this.
   local currentTime = os.difftime(os.time(), startTime) --current second(?) of information

   return tostring(file)..":"..line..": ("..currentTime.."s)\t"
end
--[[PRINT()s a line to the console providing basic info on this file]]
function Logger:info()
   print("Using Logger.lua! "..tostring(self).."\t using --console in the .bat file\n")
end
function Logger:logs()
   print("Logs: "..LogsLogged..", Warns: "..WarningsLogged..", Errors: "..ErrorsLogged)
end

--[[PRINT()s a line to the console saying "@file.lua line#: (time) (info)"]]
function Logger.Log(info)
   if type(info) ~= 'string' then
      info = tostring(info)
   end
   LogsLogged = LogsLogged + 1
   print(currentInfo()..info)
   return
end

--[[PRINT()s a line to the console saying "@file.lua line#: (time) \"(!): \" (info)"]]
function Logger.Warn(info)
   if type(info) ~= 'string' then
      info = tostring(info)
   end

   WarningsLogged = WarningsLogged + 1
   print(currentInfo().."(!): "..info)
   return
end

--[[PRINT()s a line to the console saying "@file.lua line#: (time) \"ERROR: \" (info)"]]
function Logger.Error(info)
   if type(info) ~= 'string' then
      info = tostring(info)
   end

   ErrorsLogged = ErrorsLogged + 1
   print(currentInfo().."ERROR: "..info)
   return
end


--[[PRINT()s a line to the console saying how many seconds it's been since the file has started]]
function Logger.current()
   print (currentInfo().."Hello! It has been ".. os.difftime(os.time(), startTime).." seconds since you've started")
end
function Logger.seconds()
   return os.difftime(os.time(), startTime)
end


--OK So, i found the issue, you can only use these after they have been named in static files, and idk about instance files.
--Logger:info()

--Always have this at the bottom (local functions here so they can be accessed)
return setmetatable({}, Logger) --Log = Logger.Log, Warn = Logger.Warn, Error = Logger.Error can also be here.
--return setmetatable({}, {__call = function(_, ...) return new(...) end})
