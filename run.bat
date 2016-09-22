@echo off

REM this will run Love.exe and pass in this folder as an argument.
REM use this to test the game in the Love engine.

REM syntax: EXE-LOCATION ARGUMENT
REM in this case: Love.exe PathToGameFolder

echo.
echo -------------------------------------------------------------------
echo                   Emacs_Run_JCSJava version 1.0
echo          Copyright (c) by Jen-Chieh Shen(lkk440456@gmail.com)
echo -------------------------------------------------------------------
echo.


REM "D:\Program Files\LOVE\love.exe" "%CD%" --console
REM "C:\Program Files\LOVE\love.exe" "%CD%"

REM -- Testing in other project. --
REM "C:\Program Files\LOVE\love.exe" "%CD%"
"C:\Program Files\LOVE\love.exe" "%CD%" --console


echo.
echo -------------------------------------------------------------------
echo                               END
echo -------------------------------------------------------------------
echo.
