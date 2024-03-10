::City Generation
::started at 5:42 PM on Sunday, January 17th, 2016
::by GinDiamond aka TheWinnieston/Patrick Jackson

::Recursive Division
::I've been trying different formats and layouts
::for batch file programs, trying to make them
::more and more like "real" languages, like Java
::or C# or something. Sometimes it works, sometimes
::not. I'm not particularly worried about speed
::with this script, not like the main game.

::Recursive Method Pseudocode:
::Start with one cell
::	Divide into 4 parts, 1 y, 1 x [SEED_2]
::	Randomly make an opening to each chamber on y and x
::	For each subcell, go to beginning till SEED_1 is reached.

@echo off
setlocal enabledelayedexpansion

::if not exist %2 call :coordPassError
::if not exist %3 call :seedPassError

::call template.bat

set map_width=%1
set map_height=%2
set depth=%3

set wallStepping=1
set /a hollowspace_y=%2-2
set /a hollowspace_x=%1-2
set /a lastline=%2+1
set line[0]=

for /l %%i in (1,1,%1) do (
	set line[0]=!line[0]!#
)
set line[0]=!line[0]!##

for /l %%i in (1,1,%1) do (
	set line[%lastline%]=!line[%lastline%]!#
)
set line[%lastline%]=!line[%lastline%]!##


for /l %%i in (1,1,%2) do (
	set line[%%i]=#
	for /l %%j in (-1,1,%hollowspace_x%) do (
		set line[%%i]=!line[%%i]!.
	)
	set line[%%i]=!line[%%i]!#
)

for /l %%i in (0,1,%lastline%) do (
	echo !line[%%i]!
)

pause
goto :eof