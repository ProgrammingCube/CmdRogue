::Random Walk Cave Generation Test
::started at 2:39 PM on Tuesday, October 28th, 2014
::by GinDiamond aka TheWinnieston/Patrick Jackson
@echo off
::setlocal enabledelayedexpansion

set columns=%1
set rows=%2
set floor_count=%3
set filename=%4

:: 2D map array
::set row=
::for /l %%i in (0,1,%rows%) do (
::	for /l %%j in (0,1,%columns%) do (
::		set row=!row!#
::	)
::	set line[%%i]=!row!
::	set row=
::)
setlocal enableextensions
call CORE\Generator\template.bat

:initMain

set /a pos_x=%columns%/2
set /a pos_y=%rows%/2

set /a max_x=%columns%-2
set /a max_y=%rows%-2

set /a up_pos_x=pos_x+1

set line=!line[%pos_y%]!
set line=!line:~0,%pos_x%!.!line:~%up_pos_x%!
set line[%pos_y%]=%line%

set floor_counter=0
:loop
	
:: convoluted way for boolean AND in if statements
if %pos_y% gtr 1 (
	if %pos_y% lss %max_y% (
		if %pos_x% gtr 1 (
			if %pos_x% lss %max_x% (
				call :randomGen
				if !dir! == 0 set /a pos_x+=1
				if !dir! == 1 set /a pos_y+=1
				if !dir! == 2 set /a pos_x-=1
				if !dir! == 3 set /a pos_y-=1
			) else (
				set /a pos_x-=1
			)
		) else (
			set /a pos_x+=1
		)
	) else (
		set /a pos_y-=1
	)
) else (
	set /a pos_y+=1
)

set line=!line[%pos_y%]!
set checkline=!line[%pos_y%]!

set /a chars=!pos_x!+1
set chkline=!checkline:~0,%chars%!
set c_line=!chkline:~-1!
if !c_line! == # (
	set line[%pos_y%]=!line:~0,%pos_x%!.!line:~%chars%!
	set /a floor_counter+=1
)

if %floor_counter% leq %floor_count% (
	goto loop
)
goto writefile


:randomGen
set /a dir=%random%%%4
goto :eof


:writefile
echo @echo off > %filename%.bat
for /l %%i in (0,1,%rows%) do (
	echo set line[%%i]=!line[%%i]!>> %filename%.bat
)
echo goto :eof >> %filename%.bat
goto :eof